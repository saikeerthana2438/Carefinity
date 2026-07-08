import 'package:flutter/material.dart';

class HealthSummaryCard extends StatelessWidget {
  const HealthSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.smart_toy, color: Colors.blue),
              title: Text("AI Health Assistant"),
              subtitle: Text("Get AI-powered medical guidance"),
            ),

            Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.folder_shared, color: Colors.green),
              title: Text("Digital Health Locker"),
              subtitle: Text("Securely store your reports"),
            ),

            Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.medication, color: Colors.orange),
              title: Text("Medication Reminder"),
              subtitle: Text("Never miss your medicines"),
            ),

            Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.local_hospital, color: Colors.red),
              title: Text("Doctor Consultation"),
              subtitle: Text("Book appointments instantly"),
            ),

            Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.science, color: Colors.deepPurple),
              title: Text("Diagnostics Booking"),
              subtitle: Text("Schedule lab tests online"),
            ),

            Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.family_restroom, color: Colors.teal),
              title: Text("Family Profiles"),
              subtitle: Text("Manage healthcare for your family"),
            ),
          ],
        ),
      ),
    );
  }
}