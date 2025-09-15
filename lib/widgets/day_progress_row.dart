import 'package:flutter/material.dart';

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
