import 'package:url_launcher/url_launcher.dart';
import '../../features/report_ai/screens/report_chat_screen.dart';
import 'package:provider/provider.dart';
import '../../features/report_ai/providers/report_chat_provider.dart';
import '../../models/report_model.dart';
import '../../services/report_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  File? selectedFile;
  final ReportService _reportService = ReportService();

List<ReportModel> reports = [];

bool isUploading = false;

bool isLoading = true; 

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

  final ImagePicker _picker = ImagePicker();

Future<void> pickFile() async {
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 90,
  );

  if (image != null) {
    setState(() {
      selectedFile = File(image.path);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Selected: ${image.name}"),
      ),
    );
  }
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
  setState(() {
    isLoading = true;
  });

  final data = await _reportService.getReports();

  reports = data
      .map((e) => ReportModel.fromMap(e))
      .toList();

  setState(() {
    isLoading = false;
  });
}

Future<void> uploadReport() async {
  if (selectedFile == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please select a file."),
    ),
  );
  return;
}
 

  if (reportNameController.text.trim().isEmpty ||
      hospitalController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all details."),
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

setState(() {
  selectedFile = null;
});

await loadReports();


    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Report uploaded successfully."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Reports"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Icon(
                    Icons.folder_shared,
                    size: 60,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Digital Health Locker",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Upload and securely store your medical reports.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: pickFile,
            icon: const Icon(Icons.upload_file),
            label: const Text("Choose Report Image"),
          ),

          if (selectedFile != null) ...[
            const SizedBox(height: 10),
            Text(
              selectedFile!.path.split('/').last,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],

          const SizedBox(height: 20),

          TextField(
            controller: reportNameController,
            decoration: const InputDecoration(
              labelText: "Report Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: hospitalController,
            decoration: const InputDecoration(
              labelText: "Hospital Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: reportType,
            decoration: const InputDecoration(
              labelText: "Report Type",
              border: OutlineInputBorder(),
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

          const SizedBox(height: 16),

          FilledButton.icon(
            onPressed: pickDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(
              "${reportDate.day}/${reportDate.month}/${reportDate.year}",
            ),
          ),

          const SizedBox(height: 30),

          FilledButton(
            onPressed: isUploading ? null : uploadReport,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Upload Report"),
            ),
          ),
        
        const SizedBox(height: 30),

const Text(
  "Uploaded Reports",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 15),

if (isLoading)
  const Center(
    child: CircularProgressIndicator(),
  )
else if (reports.isEmpty)
  const Card(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text("No reports uploaded yet."),
      ),
    ),
  )
else
  ...reports.map((report) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(
          Icons.description,
          color: Colors.blue,
        ),

        title: Text(report.reportName),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(report.hospitalName),
            Text(report.reportType),
            Text(
              "${report.reportDate.day}/${report.reportDate.month}/${report.reportDate.year}",
            ),
          ],
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == "view") {
              final url = await _reportService.getSignedUrl(report.fileUrl);

await launchUrl(
  Uri.parse(url),
  mode: LaunchMode.externalApplication,
);
            }

            if (value == "analyze") {
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ChangeNotifierProvider(
      create: (_) => ReportChatProvider(),
      child: const ReportChatScreen(),
    ),
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

          itemBuilder: (_) => const [
  PopupMenuItem(
    value: "view",
    child: Text("View"),
  ),
  PopupMenuItem(
    value: "analyze",
    child: Text("Analyze with AI"),
  ),
  PopupMenuItem(
    value: "delete",
    child: Text("Delete"),
  ),
],
        ),
      ),
    );
  }),
        ],
      ),
    );
  }
}