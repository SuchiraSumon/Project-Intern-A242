import 'package:beu_savings/widgets/goal_card.dart';
import 'package:flutter/material.dart';

import 'package:beu_savings/models/nest_model.dart';

import 'package:beu_savings/services/firestore_nest_service.dart';

class NestPage extends StatelessWidget {
  NestPage({super.key});

  final FirestoreNestService nestService = FirestoreNestService();

  // List<NestModel> _nests = [];
  final FirestoreNestService _nestService = FirestoreNestService();
  final String userId = "001"; // 👈 replace with FirebaseAuth later

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

            const SizedBox(height: 24),

            // Pause Nest Section
            const Text(
              "Pause Nest",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),

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

                // ✅ filter only paused nests
                final pausedNests = snapshot.data!
                    .where((nest) => !nest.active)
                    .toList();

                if (pausedNests.isEmpty) {
                  return const Text("No paused nests found.");
                }

                // ✅ Just wrap in a Column so it plays nice inside ListView
                return Column(
                  children: pausedNests.map((nest) {
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
