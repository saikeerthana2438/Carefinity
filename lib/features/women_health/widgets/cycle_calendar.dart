import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/cycle_provider.dart';

class CycleCalendar extends StatelessWidget {
  const CycleCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CycleProvider>(context);

    if (provider.cycles.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("Save your first cycle to see the calendar."),
          ),
        ),
      );
    }

    final cycle = provider.cycles.first;

    final lastPeriod = DateTime(
      cycle.lastPeriodDate.year,
      cycle.lastPeriodDate.month,
      cycle.lastPeriodDate.day,
    );

    final ovulation = lastPeriod.add(
      Duration(days: cycle.cycleLength - 14),
    );

    final fertileStart = ovulation.subtract(const Duration(days: 5));
    final fertileEnd = ovulation.add(const Duration(days: 1));

    bool isSame(DateTime a, DateTime b) =>
        a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TableCalendar(
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2035, 12, 31),
          focusedDay: DateTime.now(),

          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              if (isSame(day, lastPeriod)) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "🩸",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }

              if (isSame(day, ovulation)) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "🥚",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }

              if (day.isAfter(
                      fertileStart.subtract(const Duration(days: 1))) &&
                  day.isBefore(
                      fertileEnd.add(const Duration(days: 1)))) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${day.day}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              return null;
            },
          ),
        ),
      ),
    );
  }
}