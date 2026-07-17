import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../models/report_model.dart';
import '../../services/report_service.dart';
import 'report_analyzer_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportService _reportService = ReportService();
  final ImagePicker _picker = ImagePicker();

  File? selectedFile;

  bool isUploading = false;
  bool isLoading = true;

  List<ReportModel> reports = [];

  final reportNameController = TextEditingController();
  final hospitalController = TextEditingController();

  String reportType = "Blood Report";
  DateTime reportDate = DateTime.now();

  final List<String> reportTypes = [
    "Blood Report",
    "Prescription",
    "X-Ray",
    "MRI",
    "CT Scan",
    "ECG",
    "Vaccination",
    "Other",
  ];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  @override
  void dispose() {
    reportNameController.dispose();
    hospitalController.dispose();
    super.dispose();
  }

  Future<void> pickFile() async {
    final t = AppLocalizations.of(context)!;

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (image == null) return;

    setState(() {
      selectedFile = File(image.path);
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${t.selected}: ${image.name}",
        ),
      ),
    );
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: reportDate,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        reportDate = picked;
      });
    }
  }

  Future<void> loadReports() async {
    setState(() => isLoading = true);

    final data = await _reportService.getReports();

    reports = data.map((e) => ReportModel.fromMap(e)).toList();

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<void> uploadReport() async {
    final t = AppLocalizations.of(context)!;

    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.selectReport),
        ),
      );
      return;
    }

    if (reportNameController.text.trim().isEmpty ||
        hospitalController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.fillAllFields),
        ),
      );
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      await _reportService.uploadReport(
        file: selectedFile!,
        reportName: reportNameController.text.trim(),
        hospitalName: hospitalController.text.trim(),
        reportType: reportType,
        reportDate: reportDate,
      );

      reportNameController.clear();
      hospitalController.clear();

      selectedFile = null;

      await loadReports();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.reportUploaded),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        centerTitle: true,
        title: Text(t.medicalReports),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
                    Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2563EB),
                  Color(0xFF3B82F6),
                ],
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.folder_shared,
                  color: Colors.white,
                  size: 60,
                ),
                const SizedBox(height: 14),
                Text(
                  t.digitalHealthLocker,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.healthLockerDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.uploadNewReport,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  FilledButton.icon(
                    onPressed: pickFile,
                    icon: const Icon(Icons.upload_file),
                    label: Text(t.chooseReport),
                  ),

                  if (selectedFile != null) ...[
                    const SizedBox(height: 15),
                    Card(
                      color: Colors.green.shade50,
                      child: ListTile(
                        leading: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          selectedFile!.path.split('/').last,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  TextField(
                    controller: reportNameController,
                    decoration: InputDecoration(
                      labelText: t.reportName,
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: hospitalController,
                    decoration: InputDecoration(
                      labelText: t.hospitalName,
                      prefixIcon: const Icon(Icons.local_hospital),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  DropdownButtonFormField<String>(
                    value: reportType,
                    decoration: InputDecoration(
                      labelText: t.reportType,
                      prefixIcon: const Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: reportTypes
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        reportType = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 18),

                  FilledButton.icon(
                    onPressed: pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      "${reportDate.day}/${reportDate.month}/${reportDate.year}",
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: isUploading ? null : uploadReport,
                      icon: const Icon(Icons.cloud_upload),
                      label: Text(
                        isUploading
                            ? t.uploading
                            : t.uploadReport,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            t.uploadedReports,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),
                    if (isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (reports.isEmpty)
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Icon(
                      Icons.folder_off,
                      size: 70,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      t.noReports,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.noReportsDescription,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ...reports.map(
              (report) => Card(
                margin: const EdgeInsets.only(bottom: 18),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.description,
                              color: Colors.blue,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  report.reportName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(report.hospitalName),
                              ],
                            ),
                          ),

                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == "view") {
                                final url =
                                    await _reportService.getSignedUrl(
                                  report.fileUrl,
                                );

                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              }

                              if (value == "analyze") {
                                if (!mounted) return;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ReportAnalyzerScreen(),
                                  ),
                                );
                              }

                              if (value == "delete") {
                                await _reportService.deleteReport(
                                  id: report.id,
                                  filePath: report.fileUrl,
                                );

                                await loadReports();
                              }
                            },

                            itemBuilder: (_) => [
                              PopupMenuItem(
                                value: "view",
                                child: Text(t.view),
                              ),
                              PopupMenuItem(
                                value: "analyze",
                                child: Text(t.analyzeWithAi),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Text(t.delete),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Chip(
                            avatar: const Icon(
                              Icons.category,
                              size: 18,
                            ),
                            label: Text(report.reportType),
                          ),
                          Chip(
                            avatar: const Icon(
                              Icons.calendar_today,
                              size: 18,
                            ),
                            label: Text(
                              "${report.reportDate.day}/${report.reportDate.month}/${report.reportDate.year}",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
                    ],
      ),
    );
  }
}