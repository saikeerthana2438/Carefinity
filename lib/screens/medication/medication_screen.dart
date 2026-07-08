import 'package:flutter/material.dart';

import '../../models/medication_model.dart';
import '../../services/medication_service.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final MedicationService _service = MedicationService();

  final medicineController = TextEditingController();
  final dosageController = TextEditingController();

  List<MedicationModel> medications = [];

  bool isLoading = true;

  String frequency = "Once Daily";

  TimeOfDay reminderTime = TimeOfDay.now();

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  final frequencies = [
    "Once Daily",
    "Twice Daily",
    "Three Times Daily",
    "Weekly",
  ];

  @override
  void initState() {
    super.initState();
    loadMedications();
  }

  @override
  void dispose() {
    medicineController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  Future<void> loadMedications() async {
  setState(() {
    isLoading = true;
  });

  final data = await _service.getMedications();

  medications = data
      .map((e) => MedicationModel.fromMap(e))
      .toList();

  if (mounted) {
    setState(() {
      isLoading = false;
    });
  }
}
  
  Future<void> addMedication() async {
  if (medicineController.text.trim().isEmpty ||
      dosageController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields."),
      ),
    );
    return;
  }

  try {
    await _service.addMedication(
      medicineName: medicineController.text.trim(),
      dosage: dosageController.text.trim(),
      frequency: frequency,
      reminderTime: reminderTime.format(context),
      startDate: startDate,
      endDate: endDate,
    );

    medicineController.clear();
    dosageController.clear();

    await loadMedications();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Medication added successfully."),
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
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Reminder"),
      ),
      body: ListView(
  padding: const EdgeInsets.all(20),
  children: [
    Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.medication,
              size: 60,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            const Text(
              "Medication Reminder",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: medicineController,
              decoration: const InputDecoration(
                labelText: "Medicine Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: dosageController,
              decoration: const InputDecoration(
                labelText: "Dosage",
                hintText: "e.g. 500 mg",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: frequency,
              decoration: const InputDecoration(
                labelText: "Frequency",
                border: OutlineInputBorder(),
              ),
              items: frequencies
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  frequency = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            FilledButton.icon(
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: reminderTime,
                );

                if (picked != null) {
                  setState(() {
                    reminderTime = picked;
                  });
                }
              },
              icon: const Icon(Icons.access_time),
              label: Text(
                reminderTime.format(context),
              ),
            ),

            const SizedBox(height: 15),

            FilledButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2035),
                );

                if (picked != null) {
                  setState(() {
                    startDate = picked;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(
                "Start : ${startDate.day}/${startDate.month}/${startDate.year}",
              ),
            ),

            const SizedBox(height: 15),

            FilledButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: endDate,
                  firstDate: startDate,
                  lastDate: DateTime(2035),
                );

                if (picked != null) {
                  setState(() {
                    endDate = picked;
                  });
                }
              },
              icon: const Icon(Icons.calendar_month),
              label: Text(
                "End : ${endDate.day}/${endDate.month}/${endDate.year}",
              ),
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: addMedication,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text("Add Medication"),
              ),
            ),
          ],
        ),
      ),
    ),

    const SizedBox(height: 25),

    const Text(
      "Your Medications",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 15),

    if (isLoading)
      const Center(
        child: CircularProgressIndicator(),
      )
    else if (medications.isEmpty)
      const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("No medications added."),
          ),
        ),
      )
    else
      ...medications.map(
        (medicine) => Card(
          child: ListTile(
            leading: const Icon(
              Icons.medication,
              color: Colors.blue,
            ),
            title: Text(medicine.medicineName),
            subtitle: Text(
              "${medicine.dosage}\n${medicine.frequency}\n${medicine.reminderTime}",
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
  await _service.deleteMedication(medicine.id);

  await loadMedications();
},
            ),
          ),
        ),
      ),
  ],
),
    );
  }
}