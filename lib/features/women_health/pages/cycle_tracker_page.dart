import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cycle_model.dart';
import '../providers/cycle_provider.dart';
import '../widgets/cycle_calendar.dart';
import '../widgets/cycle_form.dart';
import '../widgets/cycle_history_card.dart';
import '../widgets/cycle_summary_card.dart';

class CycleTrackerPage extends StatefulWidget {
  const CycleTrackerPage({super.key});

  @override
  State<CycleTrackerPage> createState() => _CycleTrackerPageState();
}

class _CycleTrackerPageState extends State<CycleTrackerPage> {
  CycleModel? latestCycle;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CycleProvider>(context, listen: false).loadCycles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CycleProvider>(context);

    if (provider.cycles.isNotEmpty) {
      latestCycle = provider.cycles.first;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menstrual Cycle Tracker"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CycleForm(
              onSave: (cycle) {
                setState(() {
                  latestCycle = cycle;
                });
              },
            ),

            if (latestCycle != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: CycleSummaryCard(
                  lastPeriodDate: latestCycle!.lastPeriodDate,
                  cycleLength: latestCycle!.cycleLength,
                  periodLength: latestCycle!.periodLength,
                ),
              ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: CycleCalendar(),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cycle History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.cycles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CycleHistoryCard(
                    cycle: provider.cycles[index],
                    onDelete: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Delete Cycle"),
                          content: const Text(
                            "Are you sure you want to delete this cycle?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await provider.deleteCycle(
                          provider.cycles[index].id!,
                        );
                      }
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}