import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/report_ai_service.dart';

class ReportAnalyzerScreen extends StatefulWidget {
  const ReportAnalyzerScreen({super.key});

  @override
  State<ReportAnalyzerScreen> createState() =>
      _ReportAnalyzerScreenState();
}

class _ReportAnalyzerScreenState extends State<ReportAnalyzerScreen> {
  final ReportAIService _service = ReportAIService();

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  bool isLoading = false;

  Map<String, dynamic>? reportValues;

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return;

    setState(() {
      _selectedImage = File(file.path);
    });
  }

  Future<void> analyzeReport() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a medical report image."),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final values =
          await _service.extractReportValues(_selectedImage!);

      setState(() {
        reportValues = values;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildResult() {
    if (reportValues == null) {
      return const SizedBox();
    }

    return Card(
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: reportValues!.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              trailing: Text("${entry.value}"),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Report Analyzer"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _selectedImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_file,
                            size: 60,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Tap to Select Medical Report",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed:
                    isLoading ? null : analyzeReport,
                icon: const Icon(Icons.auto_awesome),
                label: Text(
                  isLoading
                      ? "Analyzing..."
                      : "Analyze Report",
                ),
              ),
            ),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),

            buildResult(),
          ],
        ),
      ),
    );
  }
}