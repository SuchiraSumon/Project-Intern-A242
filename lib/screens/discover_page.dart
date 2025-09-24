import 'package:beu_savings/models/user_model.dart';
import 'package:beu_savings/screens/nest_page.dart';
import 'package:beu_savings/services/firestore_user_service.dart';

import 'package:beu_savings/widgets/custom_bottom_nav.dart';
import 'package:beu_savings/widgets/day_progress_row.dart';
import 'package:beu_savings/widgets/goal_card.dart';

import 'package:beu_savings/models/nest_model.dart';

import 'package:beu_savings/services/firestore_nest_service.dart';

import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final FirestoreNestService nestService = FirestoreNestService();
  // final String userId = "001"; // TODO: replace with FirebaseAuth user.uid

  List<NestModel> _nests = [];
  final FirestoreNestService _nestService = FirestoreNestService();
  final FirestoreUserService _userService = FirestoreUserService();
  final String userId = "001"; // 👈 replace with FirebaseAuth later

  Future<void> _refresh() async {
    final freshData = await nestService.refreshNests(userId);
    setState(() {
      _nests = freshData;
    });
  }

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

      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
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
                  StreamBuilder<UserModel?>(
                    stream: _userService.streamUser(
                      userId,
                    ), // 👈 only one stream
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }

                      final user = snapshot.data;
                      if (user == null) {
                        return const Text("User not found");
                      }

                      // ✅ Now you can use both points + dayStreak here
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),

                          Text(
                            "${user.points}", // 👈 dynamically show Firestore points
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          DayProgressRow(
                            completedDay: user.dayStreak,
                          ), // 👈 use streak

                          const SizedBox(height: 16),

                          if (!user.claimed)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                minimumSize: const Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                _userService.incrementPoints(userId);
                              },
                              child: const Text(
                                "Claim (12 points)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          if (user.claimed)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  169,
                                  163,
                                  166,
                                ),
                                minimumSize: const Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Claim (12 points)", // 👈 reuse points again if needed
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
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
                      MaterialPageRoute(builder: (context) => NestPage()),
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

            // ✅ StreamBuilder directly here
            StreamBuilder<List<NestModel>>(
              stream: _nestService.getNests(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // 🟡 Show placeholder if no data
                  return goalCard(
                    context,
                    "Placeholder Nest",
                    1000,
                    200,
                    "https://via.placeholder.com/150",
                  );
                }

                final activeNests = snapshot.data!
                    .where((nest) => nest.active)
                    .toList();

                if (activeNests.isEmpty) {
                  return const Text("No active nests found.");
                }

                // ✅ Just wrap in a Column so it plays nice inside ListView
                return Column(
                  children: activeNests.map((nest) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: goalCard(
                        context,
                        nest.name,
                        nest.targetAmount,
                        nest.currentAmount,
                        nest.image,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),

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
