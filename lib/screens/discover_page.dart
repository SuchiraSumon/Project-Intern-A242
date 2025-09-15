import 'package:beu_savings/screens/nest_page.dart';
import 'package:beu_savings/widgets/custom_bottom_nav.dart';
import 'package:beu_savings/widgets/day_progress_row.dart';
import 'package:beu_savings/widgets/goal_card.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6), // light cream background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Discover",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: const AssetImage(
                "lib/assets/images/profile.jpg",
              ), // replace with your image
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // POINTS CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Points (earn Daily)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.settings, size: 20),
                          SizedBox(width: 8),
                          Icon(Icons.help_outline, size: 20),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "1,800",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  // Replaced: Day progress row (uses DayProgressRow)
                  // Set completedDay to the number of days completed (1 shows only Day 1 completed)
                  const DayProgressRow(completedDay: 1),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Claim (12 points)",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      side: const BorderSide(color: Colors.pink),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "View my rewards",
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // NEST HEADER
            // NEST HEADER with navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nest",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NestPage()),
                    );
                  },
                  child: const Text(
                    "View more",
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // LIST OF GOALS with Progress Circles
            Column(
              children: [
                goalCard("Pangkor", 380, 210, "lib/assets/images/travel.png"),
                const SizedBox(height: 12),
                goalCard("Car", 3500, 1000, "lib/assets/images/car.jpg"),
                const SizedBox(height: 12),
                goalCard(
                  "Birthday",
                  300,
                  250,
                  "lib/assets/images/birthday.jpg",
                ),
              ],
            ),
          ],
        ),
      ),

      // Bottom Navigation
      // Bottom Navigation
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 2, // Discover is selected
        onTap: (index) {
          // 🔹 Add navigation handling later
          debugPrint("Tapped on tab $index");
        },
      ),
    );
  }
}
