import 'package:flutter/material.dart';

class PcosPage extends StatelessWidget {
  const PcosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PCOS Symptoms"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.favorite, size: 80, color: Colors.pink),
            SizedBox(height: 20),
            Text(
              "PCOS Symptom Tracker",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Track acne, weight changes, hair growth, irregular periods and other PCOS symptoms.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}