import '../../services/diagnostic_booking_service.dart';
import 'package:flutter/material.dart';

class DiagnosticBookingScreen extends StatefulWidget {
  final String centerName;
  final String testName;
  final String price;

  const DiagnosticBookingScreen({
    super.key,
    required this.centerName,
    required this.testName,
    required this.price,
  });

  @override
  State<DiagnosticBookingScreen> createState() =>
      _DiagnosticBookingScreenState();
}

class _DiagnosticBookingScreenState
    extends State<DiagnosticBookingScreen> {
  final TextEditingController nameController =
      TextEditingController();
  final DiagnosticBookingService _bookingService =
    DiagnosticBookingService();

  final TextEditingController phoneController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

  String selectedTime = "09:00 AM";

  bool homeCollection = true;

  final List<String> slots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "02:00 PM",
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
        title: const Text("Book Diagnostic Test"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    widget.centerName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(widget.testName),

                  const SizedBox(height: 8),

                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

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

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: pickDate,
            icon: const Icon(Icons.calendar_month),
            label: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            ),
          ),

          const SizedBox(height: 24),

          DropdownButtonFormField<String>(
            value: selectedTime,
            decoration: const InputDecoration(
              labelText: "Select Time",
              border: OutlineInputBorder(),
            ),
            items: slots
                .map(
                  (slot) => DropdownMenuItem(
                    value: slot,
                    child: Text(slot),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedTime = value!;
              });
            },
          ),

          const SizedBox(height: 24),

          SwitchListTile(
            title: const Text("Home Collection"),
            subtitle: const Text(
              "Sample collected from your home",
            ),
            value: homeCollection,
            onChanged: (value) {
              setState(() {
                homeCollection = value;
              });
            },
          ),

          const SizedBox(height: 30),

          FilledButton(
            onPressed: () async {
  if (nameController.text.isEmpty ||
      phoneController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all details"),
      ),
    );
    return;
  }

  try {
    await _bookingService.bookDiagnostic(
      patientName: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      centerName: widget.centerName,
      testName: widget.testName,
      price: widget.price,
      bookingDate: selectedDate,
      bookingTime: selectedTime,
      homeCollection: homeCollection,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Diagnostic test booked successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Booking failed: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
},
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Confirm Booking"),
            ),
          ),
        ],
      ),
    );
  }
}