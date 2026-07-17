import 'package:flutter/material.dart';
import 'cycle_tracker_page.dart';
import 'pregnancy_page.dart';
import 'fertility_page.dart';
import 'pcos_page.dart';
import 'menopause_page.dart';
import 'iron_tracker_page.dart';
import 'reminders_page.dart';
class WomenHealthDashboardPage extends StatelessWidget {
  const WomenHealthDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Women's Health"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _buildCard(
  context,
  Icons.favorite,
  "Menstrual Cycle",
  "Track your monthly cycle",
  CycleTrackerPage(),
),

         _buildCard(
  context,
  Icons.pregnant_woman,
  "Pregnancy Tracker",
  "Track pregnancy progress",
  PregnancyPage(),
),

          _buildCard(
  context,
  Icons.spa,
  "Fertility Window",
  "Know your fertile days",
  FertilityPage(),
),

          _buildCard(
  context,
  Icons.health_and_safety,
  "PCOS Symptoms",
  "Track symptoms daily",
  PcosPage(),

),

          _buildCard(
  context,
  Icons.local_florist,
  "Menopause",
  "Monitor menopause symptoms",
  MenopausePage(),
),

          _buildCard(
  context,
  Icons.medical_services,
  "Iron Deficiency",
  "Track iron deficiency symptoms",
  IronTrackerPage(),
),

          _buildCard(
  context,
  Icons.notifications,
  "Reminders",
  "Medication & health reminders",
  RemindersPage(),
),
        ],
      ),
    );
  }

  Widget _buildCard(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  Widget page,
) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          icon,
          size: 35,
          color: Colors.pink,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (_) => page,
    ),
  );
},
      ),
    );
  }
}