import '../../data/diagnostic_centers.dart';
import 'diagnostic_center_screen.dart';
import '../../services/diagnostic_service.dart';
import 'package:flutter/material.dart';

class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  State<DiagnosticsScreen> createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  final DiagnosticService _diagnosticService = DiagnosticService();

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnostics"),
        centerTitle: true,
      ),
      body: ListView.builder(
  padding: const EdgeInsets.all(16),
  itemCount: diagnosticCenters.length,
  itemBuilder: (context, index) {
    final center = diagnosticCenters[index] as Map<String, dynamic>;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.local_hospital),
        ),

        title: Text(center["name"] as String),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("⭐ ${center["rating"]}"),

            Text(center["address"] as String),

            Text(
              (center["homeCollection"] as bool)
                  ? "🏠 Home Collection Available"
                  : "🏥 Visit Center",
            ),
          ],
        ),

        trailing: const Icon(Icons.arrow_forward_ios),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DiagnosticCenterScreen(
                center: center,
                ),
            ),
          );
        },
      ),
    );
  },
)
    );
  }
}