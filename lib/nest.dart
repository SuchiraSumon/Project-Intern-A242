import 'package:flutter/material.dart';
import 'main.dart'; // so we can reuse goalCard() and TravelProgress

class NestPage extends StatelessWidget {
  const NestPage({super.key});

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
          "Nest",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create New Nest button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.add_box_rounded, color: Colors.black, size: 28),
                  SizedBox(width: 12),
                  Text(
                    "Create New Nest",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Active Nest Section
            const Text(
              "Active Nest",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),

            Column(
              children: [
                goalCard(
                  "Pangkor",
                  "RM 380",
                  const TravelProgress(
                    percent: 0.6,
                    image: "lib/assets/images/travel.png",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Car",
                  "RM 3500",
                  const TravelProgress(
                    percent: 0.3,
                    image: "lib/assets/images/car.jpg",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Birthday",
                  "RM 300",
                  const TravelProgress(
                    percent: 0.9,
                    image: "lib/assets/images/birthday.jpg",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Family Day",
                  "RM 500",
                  const TravelProgress(
                    percent: 0.5,
                    image: "lib/assets/images/travel.png",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Pause Nest Section
            const Text(
              "Pause Nest",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),

            Column(
              children: [
                goalCard(
                  "Medical Checkup",
                  "RM 100",
                  const TravelProgress(
                    percent: 0.2,
                    image: "lib/assets/images/medical.png",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Emergency",
                  "RM 0",
                  const TravelProgress(
                    percent: 0.0,
                    image: "lib/assets/images/medical.png",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
