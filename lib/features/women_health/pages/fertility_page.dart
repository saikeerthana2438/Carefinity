import 'package:flutter/material.dart';

class FertilityPage extends StatelessWidget {
  const FertilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertility Window"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.spa, size: 80, color: Colors.pink),
            SizedBox(height: 20),
            Text(
              "Fertility Window",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "This page will help users predict fertile days based on their menstrual cycle.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}