import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cycle_model.dart';
import '../providers/cycle_provider.dart';

class CycleForm extends StatefulWidget {
  final ValueChanged<CycleModel> onSave;
  final CycleModel? cycle;

  const CycleForm({
    super.key,
    required this.onSave,
    this.cycle,
  });

  @override
  State<CycleForm> createState() => _CycleFormState();
}

class _CycleFormState extends State<CycleForm> {
  DateTime? selectedDate;

  final cycleController = TextEditingController(text: "28");
  final periodController = TextEditingController(text: "5");
  final notesController = TextEditingController();

  String mood = "Happy";

  final List<String> symptoms = [
    "Cramps",
    "Headache",
    "Back Pain",
    "Bloating",
    "Acne",
    "Fatigue",
  ];

  final List<String> selectedSymptoms = [];

    @override
  void initState() {
    super.initState();

    if (widget.cycle != null) {
      selectedDate = widget.cycle!.lastPeriodDate;
      cycleController.text = widget.cycle!.cycleLength.toString();
      periodController.text = widget.cycle!.periodLength.toString();
      mood = widget.cycle!.mood;

      selectedSymptoms.clear();
      selectedSymptoms.addAll(widget.cycle!.symptoms);

      notesController.text = widget.cycle!.notes;
    }
  }

  @override
  void didUpdateWidget(covariant CycleForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.cycle?.id != oldWidget.cycle?.id &&
        widget.cycle != null) {
      setState(() {
        selectedDate = widget.cycle!.lastPeriodDate;
        cycleController.text = widget.cycle!.cycleLength.toString();
        periodController.text = widget.cycle!.periodLength.toString();
        mood = widget.cycle!.mood;

        selectedSymptoms
          ..clear()
          ..addAll(widget.cycle!.symptoms);

        notesController.text = widget.cycle!.notes;
      });
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildMoodButton(String emoji, String value) {
    final selected = mood == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          mood = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.pink.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? Colors.pink : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cycleController.dispose();
    periodController.dispose();
    notesController.dispose();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Center(
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 60,
                ),
                SizedBox(height: 10),
                Text(
                  "Menstrual Cycle Tracker",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Track your cycle and predict your next period",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.pink),
                      SizedBox(width: 10),
                      Text(
                        "Last Period Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: pickDate,
                      icon: const Icon(Icons.date_range),
                      label: Text(
                        selectedDate == null
                            ? "Select Date"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.pink),
                      SizedBox(width: 10),
                      Text(
                        "Cycle Length",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle, size: 35),
                        color: Colors.pink,
                        onPressed: () {
                          int value = int.parse(cycleController.text);

                          if (value > 20) {
                            setState(() {
                              cycleController.text = "${value - 1}";
                            });
                          }
                        },
                      ),

                      Text(
                        "${cycleController.text} Days",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.add_circle, size: 35),
                        color: Colors.pink,
                        onPressed: () {
                          int value = int.parse(cycleController.text);

                          setState(() {
                            cycleController.text = "${value + 1}";
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
                    const SizedBox(height: 20),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.water_drop, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "Period Length",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle, size: 35),
                        color: Colors.red,
                        onPressed: () {
                          int value = int.parse(periodController.text);

                          if (value > 2) {
                            setState(() {
                              periodController.text = "${value - 1}";
                            });
                          }
                        },
                      ),

                      Text(
                        "${periodController.text} Days",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.add_circle, size: 35),
                        color: Colors.red,
                        onPressed: () {
                          int value = int.parse(periodController.text);

                          if (value < 10) {
                            setState(() {
                              periodController.text = "${value + 1}";
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_emotions, color: Colors.amber),
                      SizedBox(width: 10),
                      Text(
                        "How are you feeling today?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMoodButton("😍", "Very Happy"),
                      _buildMoodButton("😊", "Happy"),
                      _buildMoodButton("😐", "Normal"),
                      _buildMoodButton("😔", "Sad"),
                      _buildMoodButton("😢", "Very Sad"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Symptoms",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: symptoms.map((symptom) {
              final selected = selectedSymptoms.contains(symptom);

              return FilterChip(
                label: Text(symptom),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      selectedSymptoms.add(symptom);
                    } else {
                      selectedSymptoms.remove(symptom);
                    }
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Notes",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),
                    SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select the last period date"),
                    ),
                  );
                  return;
                }

                final cycle = CycleModel(
                  id: widget.cycle?.id,
                  lastPeriodDate: selectedDate!,
                  cycleLength: int.tryParse(cycleController.text) ?? 28,
                  periodLength: int.tryParse(periodController.text) ?? 5,
                  mood: mood,
                  symptoms: List<String>.from(selectedSymptoms),
                  notes: notesController.text,
                  createdAt: widget.cycle?.createdAt ?? DateTime.now(),
                );

                final provider =
                    Provider.of<CycleProvider>(context, listen: false);

                try {
                  if (widget.cycle == null) {
                    await provider.addCycle(cycle);
                  } else {
                    await provider.updateCycle(cycle);
                  }

                  widget.onSave(cycle);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.cycle == null
                            ? "Cycle saved successfully!"
                            : "Cycle updated successfully!",
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
              child: Text(
                widget.cycle == null ? "Save Cycle" : "Update Cycle",
              ),
            ),
          ),
        ],
      ),
    );
  }
}