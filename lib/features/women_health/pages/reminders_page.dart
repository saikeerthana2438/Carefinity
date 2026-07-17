import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.notifications_active,
                size: 80, color: Colors.pink),
            SizedBox(height: 20),
            Text(
              "Health Reminders",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Set reminders for medicines, water intake, doctor appointments, and health checkups.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}