import '../../services/appointment_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final String doctorName;
  final String speciality;

  const AppointmentBookingScreen({
    super.key,
    required this.doctorName,
    required this.speciality,
  });

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState
    extends State<AppointmentBookingScreen> {

final TextEditingController nameController = TextEditingController();

final TextEditingController phoneController = TextEditingController();

final TextEditingController reasonController = TextEditingController();

final AppointmentService _appointmentService = AppointmentService();

  DateTime selectedDate = DateTime.now();

  String selectedTime = "10:00 AM";

  final List<String> slots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "04:00 PM",
  ];

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 60),
      ),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          widget.doctorName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(widget.speciality),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
  "Patient Details",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

TextField(
  controller: nameController,
  decoration: const InputDecoration(
    labelText: "Patient Name",
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.person),
  ),
),

const SizedBox(height: 16),

TextField(
  controller: phoneController,
  keyboardType: TextInputType.phone,
  decoration: const InputDecoration(
    labelText: "Phone Number",
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.phone),
  ),
),

const SizedBox(height: 16),

TextField(
  controller: reasonController,
  maxLines: 3,
  decoration: const InputDecoration(
    labelText: "Reason for Visit",
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.description),
  ),
),

const SizedBox(height: 30),

          const Text(
            "Select Appointment Date",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            onPressed: pickDate,
            icon: const Icon(Icons.calendar_month),
            label: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Available Time Slots",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: slots.map((time) {
              final selected = selectedTime == time;

              return ChoiceChip(
                label: Text(time),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 40),

          FilledButton(
            onPressed: () async {
  if (nameController.text.isEmpty ||
      phoneController.text.isEmpty ||
      reasonController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all details"),
      ),
    );
    return;
  }

  try {
    await _appointmentService.bookAppointment(
      patientName: nameController.text.trim(),
      doctorName: widget.doctorName,
      specialization: widget.speciality,
      appointmentDate: selectedDate,
      appointmentTime: selectedTime,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Appointment booked successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  } on AuthException {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please login first."),
        backgroundColor: Colors.red,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Booking failed: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
},
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Text(
                "Confirm Booking",
              ),
            ),
          ),
        ],
      ),
    );
  }
}