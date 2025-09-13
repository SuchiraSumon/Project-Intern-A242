import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'nest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialised");
  } catch (e) {
    print(" Firebase Failed : $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hides the red debug banner
      title: 'Discover Page Demo',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const DiscoverPage(), // ✅ directly open DiscoverPage
    );
  }
}

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
                goalCard(
                  "Pangkor",
                  "RM 380",
                  TravelProgress(
                    percent: 0.6,
                    image: "lib/assets/images/travel.png",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Car",
                  "RM 3500",
                  TravelProgress(
                    percent: 0.3,
                    image: "lib/assets/images/car.jpg",
                  ),
                ),
                const SizedBox(height: 12),
                goalCard(
                  "Birthday",
                  "RM 300",
                  TravelProgress(
                    percent: 0.9,
                    image: "lib/assets/images/birthday.jpg",
                  ),
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

// ✅ Custom Bottom Navigation Bar
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95, // 👈 fixed height
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, "Home", 0),
          _buildNavItem(Icons.account_balance_wallet, "Pocket", 1),
          _buildNavItem(Icons.favorite, "Discover", 2),
          _buildNavItem(Icons.pie_chart, "Budget", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: isActive ? const Color(0xFFCC0D5A) : Colors.grey,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFFCC0D5A) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Goal Card with Progress Widget
Widget goalCard(String title, String price, Widget progress) {
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
            Text(price, style: const TextStyle(color: Colors.black54)),
          ],
        ),
        progress, // ✅ progress circle injected here
      ],
    ),
  );
}

// 🔹 Progress Circle Widget
class TravelProgress extends StatelessWidget {
  final double percent;
  final String image;

  const TravelProgress({super.key, required this.percent, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 6.0,
      percent: percent, // e.g. 0.6 = 60%
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.grey.shade200,
      progressColor: Colors.pink,
      center: Image.asset(image, width: 28, height: 28),
    );
  }
}

/// DayProgressRow
/// Shows 5 day indicators: completed days are filled pink with a check,
/// remaining days show an outlined circle with a small pink dot inside.
/// Use `completedDay` to set how many days are completed (e.g. 1).
/// DayProgressRow with connecting line
class DayProgressRow extends StatelessWidget {
  final int completedDay; // e.g., 1 means only Day 1 is completed

  const DayProgressRow({super.key, required this.completedDay});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double spacing = totalWidth / 4; // space between each circle

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Background line (uncompleted part)
            Positioned(
              top: 18, // aligns with circle center
              left: 18,
              right: 18,
              child: Container(
                height: 1,
                color: const Color(0x29E41B6C), // soft pink 16% opacity
              ),
            ),

            // Completed part of the line
            Positioned(
              top: 18,
              left: 18,
              child: Container(
                height: 1,
                width: completedDay > 1 ? spacing * (completedDay - 1) : 0,
                color: const Color(0xFFCC0D5A), // completed pink
              ),
            ),

            // Circles with labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final int dayNumber = index + 1;
                final bool isCompleted = dayNumber <= completedDay;

                return Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? const Color(0xFFCC0D5A)
                            : Colors.white,
                        border: Border.all(
                          color: const Color(0xFFCC0D5A),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                size: 18,
                                color: Colors.white,
                              )
                            : Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCC0D5A),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Day $dayNumber',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
