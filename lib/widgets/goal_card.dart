import 'package:flutter/material.dart';
import '../screens/amount_page.dart'; // 👈 make sure this path is correct
import 'travel_progress.dart';

Widget goalCard(
  BuildContext context, // 👈 need context for Navigator
  String title,
  double targetAmount,
  double currentAmount,
  String imageUrl,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AmountPage(
            title: title,
            targetAmount: targetAmount,
            currentAmount: currentAmount,
            imageUrl: imageUrl,
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                "RM${targetAmount.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          TravelProgress(
            percent: currentAmount / targetAmount,
            image: imageUrl,
          ), // ✅ progress circle injected here
        ],
      ),
    ),
  );
}
