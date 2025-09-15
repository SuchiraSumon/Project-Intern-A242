import 'package:flutter/material.dart';

import 'travel_progress.dart';

Widget goalCard(
  String title,
  double target_amount,
  double current_amount,
  String image_url,
) {
  return Container(
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
              target_amount.toString(),
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
        TravelProgress(
          percent: current_amount / target_amount,
          image: image_url,
        ), // ✅ progress circle injected here
      ],
    ),
  );
}
