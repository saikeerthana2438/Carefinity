import 'diagnostic_booking_screen.dart';
import 'package:flutter/material.dart';

class DiagnosticCenterScreen extends StatelessWidget {
  final Map<String, dynamic> center;

  const DiagnosticCenterScreen({
    super.key,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    final tests = center["tests"] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(center["name"]),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    center["name"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.amber),
                      const SizedBox(width: 6),
                      Text(center["rating"].toString()),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(center["address"]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 8),
                      Text(center["phone"]),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text(center["openingHours"]),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(
                        center["homeCollection"]
                            ? Icons.home
                            : Icons.close,
                        color: center["homeCollection"]
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        center["homeCollection"]
                            ? "Home Collection Available"
                            : "Home Collection Not Available",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Available Tests",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ...tests.map((test) {
            return Card(
              child: ListTile(
                title: Text(test["name"]),
                subtitle: Text(test["price"]),
                trailing: FilledButton(
                  onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DiagnosticBookingScreen(
        centerName: center["name"] as String,
        testName: test["name"] as String,
        price: test["price"] as String,
      ),
    ),
  );
},
                  child: const Text("Book"),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}