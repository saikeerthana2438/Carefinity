import 'package:flutter/material.dart';

import '../../services/report_ai_service.dart';

class ReportAnalyzerScreen extends StatefulWidget {
  const ReportAnalyzerScreen({super.key});

  @override
  State<ReportAnalyzerScreen> createState() =>
      _ReportAnalyzerScreenState();
}

class _ReportAnalyzerScreenState
    extends State<ReportAnalyzerScreen> {

  final ReportAIService _service = ReportAIService();

  final TextEditingController reportController =
      TextEditingController();

  String result = "";

  bool isLoading = false;

  Future<void> analyze() async {
    if (reportController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please paste the report text."),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    result = await _service.analyzeReport(
      reportController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Report Analyzer"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Text(
            "Paste Medical Report",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: reportController,
            maxLines: 12,
            decoration: const InputDecoration(
              hintText:
                  "Paste your blood report, prescription or medical report here...",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: isLoading ? null : analyze,
            icon: const Icon(Icons.auto_awesome),
            label: const Text("Analyze Report"),
          ),

          const SizedBox(height: 30),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          if (result.isNotEmpty) ...[
            const Text(
              "AI Analysis",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}