import 'package:flutter/material.dart';

class MenopausePage extends StatelessWidget {
  const MenopausePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menopause"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.local_florist,
                size: 80, color: Colors.deepOrange),
            SizedBox(height: 20),
            Text(
              "Menopause Tracker",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Track hot flashes, sleep quality, mood changes and other menopause symptoms.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}