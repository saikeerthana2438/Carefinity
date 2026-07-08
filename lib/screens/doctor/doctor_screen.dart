import 'package:flutter/material.dart';
import '../appointments/appointment_booking_screen.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      {
        "name": "Dr. Sarah Johnson",
        "speciality": "Cardiologist",
        "experience": "12 Years",
        "rating": "4.9",
      },
      {
        "name": "Dr. Michael Lee",
        "speciality": "Dermatologist",
        "experience": "9 Years",
        "rating": "4.8",
      },
      {
        "name": "Dr. Priya Sharma",
        "speciality": "General Physician",
        "experience": "15 Years",
        "rating": "4.9",
      },
      {
        "name": "Dr. David Wilson",
        "speciality": "Orthopedic",
        "experience": "11 Years",
        "rating": "4.7",
      },
      {
        "name": "Dr. Emily Brown",
        "speciality": "Pediatrician",
        "experience": "8 Years",
        "rating": "4.8",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Consultation"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor["name"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(doctor["speciality"]!),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(doctor["rating"]!),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.work_outline,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(doctor["experience"]!),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AppointmentBookingScreen(
          doctorName: doctor["name"]!,
          speciality: doctor["speciality"]!,
        ),
      ),
    );
  },
  child: const Text("Book"),
),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}