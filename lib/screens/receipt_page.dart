import 'dart:math';
import 'package:flutter/material.dart';

class ReceiptPage extends StatelessWidget {
  final String amount;
  final String nestName;
  final String nestAccount;
  final String payFrom;

  const ReceiptPage({
    super.key,
    required this.amount,
    required this.nestName,
    required this.nestAccount,
    required this.payFrom,
  });

  String _generateRefNo() {
    final random = Random();
    return List.generate(15, (_) => random.nextInt(10)).join();
  }

  @override
  Widget build(BuildContext context) {
    final String transactionRef = _generateRefNo();
    final now = DateTime.now();
    final String formattedDateTime =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}   "
        "${(now.hour % 12 == 0 ? 12 : now.hour % 12).toString().padLeft(2, '0')}:"
        "${now.minute.toString().padLeft(2, '0')} "
        "${now.hour >= 12 ? 'P.M.' : 'A.M.'}";

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            // Success icon
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink, width: 2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.pink, size: 28),
              ),
            ),

            const SizedBox(height: 20),

            // Transfer amount
            Center(
              child: Column(
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

            // Transfer to
            _infoTile("Transfer to", "$nestName\n$nestAccount"),

            // Transaction Ref
            _infoTile("Transaction Ref. No.", transactionRef),

            // Pay from
            _infoTile("Pay from", payFrom),

            // Date & Time
            _infoTile("Date and Time", formattedDateTime),

            const Spacer(),

            // Back to Discover button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "Back to Discover",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
