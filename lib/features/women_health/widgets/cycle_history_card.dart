import 'package:flutter/material.dart';
import '../models/cycle_model.dart';

class CycleHistoryCard extends StatelessWidget {
  final CycleModel cycle;
  final VoidCallback onDelete;

  const CycleHistoryCard({
    super.key,
    required this.cycle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(

        leading: const Icon(Icons.calendar_today),
        title: Text(
          "Last Period: ${cycle.lastPeriodDate.day}/${cycle.lastPeriodDate.month}/${cycle.lastPeriodDate.year}",
        ),
        subtitle: Text(
          "Cycle: ${cycle.cycleLength} days\n"
          "Period: ${cycle.periodLength} days\n"
          "Mood: ${cycle.mood}",
        ),
        trailing: IconButton(
  icon: const Icon(
    Icons.delete,
    color: Colors.red,
  ),
  onPressed: onDelete,
),

        
      ),
    );
  }
}