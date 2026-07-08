import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      const _Doctor(
        name: "Dr. Sarah Johnson",
        speciality: "Cardiologist",
        experience: "12 Years",
        rating: 4.9,
      ),
      const _Doctor(
        name: "Dr. Michael Lee",
        speciality: "Dermatologist",
        experience: "9 Years",
        rating: 4.8,
      ),
      const _Doctor(
        name: "Dr. Priya Sharma",
        speciality: "General Physician",
        experience: "15 Years",
        rating: 4.9,
      ),
    ];

    return SizedBox(
      height: 255,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Container(
            width: 280,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(
                    Icons.person,
                    size: 34,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  doctor.speciality,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text("${doctor.rating}"),
                    const Spacer(),
                    Text(doctor.experience),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
  width: double.infinity,
  height: 42,
  child: FilledButton(
    onPressed: () {},
    child: const Text("Book Appointment"),
  ),
),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Doctor {
  final String name;
  final String speciality;
  final String experience;
  final double rating;

  const _Doctor({
    required this.name,
    required this.speciality,
    required this.experience,
    required this.rating,
  });
}