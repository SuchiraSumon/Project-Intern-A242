import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
