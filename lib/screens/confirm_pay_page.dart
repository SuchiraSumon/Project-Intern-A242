import 'package:beu_savings/models/transfer_model.dart';
import 'package:beu_savings/models/user_model.dart';
import 'package:beu_savings/screens/receipt_page.dart';
import 'package:beu_savings/services/firestore_nest_service.dart';
import 'package:beu_savings/services/firestore_transfer_service.dart';
import 'package:beu_savings/services/firestore_user_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ConfirmPayPage extends StatelessWidget {
  final String amount;
  final String nestName;
  final String nestAccount;
  final String payFrom;

  final FirestoreNestService nestService = FirestoreNestService();
  final FirestoreTransferService transferService = FirestoreTransferService();
  final FirestoreUserService userService = FirestoreUserService();

  ConfirmPayPage({
    super.key,
    required this.amount,
    required this.nestName,
    required this.nestAccount,
    required this.payFrom,
  });

  Future<void> handleTransfer(String userId) async {
    final now = DateTime.now();

    // CHECK first (before saving the new transfer)
    final transferredRecently = await transferService
        .hasTransferredInLast24Hours(userId);

    if (!transferredRecently) {
      // atomic increment is nicer — but this simple update works.
      await userService.incrementDayStreak(
        userId,
      ); // see next block for this helper
    }

    // Now save the transfer (so it won't affect the check we already did)
    final transferId = const Uuid().v4();
    final transfer = TransferModel(
      id: transferId,
      datetime: now,
      transferType: 'duitNow',
    );
    await transferService.setTransfer(userId, transfer);
  }

  Future<void> _transferToNest() async {
    final double amt = double.tryParse(amount) ?? 0;

    if (amt <= 0) return;

    // Call Firestore service to update the nest's current_amount
    await nestService.updateNestAmount(nestName: nestName, addedAmount: amt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Transfer to nest",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Transfer amount
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Transfer amount",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Text(
                  "RM$amount",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Divider(height: 1),

          // Transfer to section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.pink.shade100,
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      "lib/assets/images/travel.png",
                    ), // example image
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Transfer to",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nestName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      nestAccount,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Pay from section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pay from",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  payFrom,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Slide to transfer button
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            width: double.infinity,
            child: GestureDetector(
              onHorizontalDragEnd: (_) async {
                // 1️⃣ Update Nest amount
                await handleTransfer("001");
                await _transferToNest();

                // 2️⃣ Navigate to receipt page
                debugPrint("Transfer confirmed!");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptPage(
                      amount: amount,
                      nestName: nestName,
                      nestAccount: nestAccount,
                      payFrom: payFrom,
                    ),
                  ),
                );
              },

              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Slide to transfer",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
