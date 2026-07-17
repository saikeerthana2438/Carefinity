import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/report_ai_service.dart';

class ReportAnalyzerScreen extends StatefulWidget {
  const ReportAnalyzerScreen({super.key});

  @override
  State<ReportAnalyzerScreen> createState() =>
      _ReportAnalyzerScreenState();
}

class _ReportAnalyzerScreenState extends State<ReportAnalyzerScreen> {
  final ReportAIService _service = ReportAIService();

  final TextEditingController reportController =
      TextEditingController();

  String result = "";
  bool isLoading = false;

  Future<void> analyze() async {
    final t = AppLocalizations.of(context)!;

    if (reportController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.pasteReportText),
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

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.aiReportAnalyzer),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            t.pasteMedicalReport,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: reportController,
            maxLines: 12,
            decoration: InputDecoration(
              hintText: t.reportHint,
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: isLoading ? null : analyze,
            icon: const Icon(Icons.auto_awesome),
            label: Text(
              isLoading
                  ? t.analyzing
                  : t.analyzeReport,
            ),
          ),

          const SizedBox(height: 30),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          if (result.isNotEmpty) ...[
            Text(
              t.aiAnalysis,
              style: const TextStyle(
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
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}