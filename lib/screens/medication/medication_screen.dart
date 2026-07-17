import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

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
  final t = AppLocalizations.of(context)!;
    if (medicineController.text.trim().isEmpty ||
        dosageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.fillAllFields),
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
          SnackBar(
            content: Text(t.medicationAdded),
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
  final t = AppLocalizations.of(context)!;

  return Scaffold(
    appBar: AppBar(
      title: Text(t.medicationReminder),
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

                Text(
                  t.medicationReminder,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: medicineController,
                  decoration: InputDecoration(
                    labelText: t.medicineName,
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: dosageController,
                  decoration: InputDecoration(
                    labelText: t.dosage,
                    hintText: t.dosageHint,
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: frequency,
                  decoration: InputDecoration(
                    labelText: t.frequency,
                    border: const OutlineInputBorder(),
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
                    "${t.startDate} : ${startDate.day}/${startDate.month}/${startDate.year}",
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
                    "${t.endDate} : ${endDate.day}/${endDate.month}/${endDate.year}",
                  ),
                ),

                const SizedBox(height: 20),

                FilledButton(
                  onPressed: addMedication,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(t.addMedication),
                  ),
                ),
              ],
            ),
          ),
        ),
                const SizedBox(height: 25),

        Text(
          t.yourMedications,
          style: const TextStyle(
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(t.noMedications),
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
                  "${medicine.dosage}\n"
                  "${medicine.frequency}\n"
                  "${medicine.reminderTime}",
                ),
                isThreeLine: true,
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
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