import 'package:flutter/material.dart';

class CycleSummaryCard extends StatelessWidget {
  final DateTime lastPeriodDate;
  final int cycleLength;
  final int periodLength;

  const CycleSummaryCard({
    super.key,
    required this.lastPeriodDate,
    required this.cycleLength,
    required this.periodLength,
  });

  @override
  Widget build(BuildContext context) {
    final nextPeriod = lastPeriodDate.add(
      Duration(days: cycleLength),
    );

    final ovulation = lastPeriodDate.add(
      Duration(days: cycleLength - 14),
    );

    final fertileStart = ovulation.subtract(
      const Duration(days: 5),
    );

    final fertileEnd = ovulation.add(
      const Duration(days: 1),
    );

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Cycle Prediction",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "🩸 Next Period: "
              "${nextPeriod.day}/${nextPeriod.month}/${nextPeriod.year}",
            ),

            const SizedBox(height: 10),

            Text(
              "🥚 Ovulation Day: "
              "${ovulation.day}/${ovulation.month}/${ovulation.year}",
            ),

            const SizedBox(height: 10),

            Text(
              "🌸 Fertile Window:",
            ),

            Text(
              "${fertileStart.day}/${fertileStart.month}"
              "  →  "
              "${fertileEnd.day}/${fertileEnd.month}",
            ),

            const SizedBox(height: 10),

            Text(
              "🗓 Period Length: $periodLength days",
            ),
          ],
        ),
      ),
    );
  }
}