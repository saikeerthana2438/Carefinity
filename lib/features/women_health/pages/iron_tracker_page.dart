import 'package:flutter/material.dart';

class IronTrackerPage extends StatelessWidget {
  const IronTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iron Deficiency"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.medical_services,
                size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text(
              "Iron Deficiency Tracker",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Monitor fatigue, dizziness, weakness and iron supplement reminders.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}