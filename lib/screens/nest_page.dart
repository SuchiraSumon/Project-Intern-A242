import 'package:beu_savings/screens/amount_page.dart';
import 'package:beu_savings/widgets/goal_card.dart';
import 'package:flutter/material.dart';

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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AmountPage(),
                      ),
                    );
                  },
                  child: goalCard(
                    "Pangkor",
                    380,
                    210,
                    "lib/assets/images/travel.png",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard("Car", 3500, 1000, "lib/assets/images/car.jpg"),
                const SizedBox(height: 12),
                goalCard(
                  "Birthday",
                  300,
                  250,
                  "lib/assets/images/birthday.jpg",
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Family Day",
                  500,
                  250,
                  "lib/assets/images/travel.png",
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
                  100,
                  20,
                  "lib/assets/images/medical.png",
                ),
                const SizedBox(height: 12),
                goalCard("Emergency", 1000, 0, "lib/assets/images/medical.png"),
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
