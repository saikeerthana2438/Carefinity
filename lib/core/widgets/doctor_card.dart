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
        patients: "3.5K+",
        color: Color(0xFFE8F1FF),
      ),
      const _Doctor(
        name: "Dr. Michael Lee",
        speciality: "Dermatologist",
        experience: "9 Years",
        rating: 4.8,
        patients: "2.7K+",
        color: Color(0xFFE9FFF2),
      ),
      const _Doctor(
        name: "Dr. Priya Sharma",
        speciality: "General Physician",
        experience: "15 Years",
        rating: 4.9,
        patients: "5K+",
        color: Color(0xFFFFF6E6),
      ),
    ];

    return SizedBox(
      height: 285,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      CircleAvatar(
                        radius: 34,
                        backgroundColor: doctor.color,
                        child: const Icon(
                          Icons.person,
                          size: 38,
                          color: Color(0xFF2563EB),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              doctor.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              doctor.speciality,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [

                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 18,
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  doctor.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [

                      Expanded(
                        child: _InfoCard(
                          icon: Icons.work_outline,
                          title: doctor.experience,
                          subtitle: "Experience",
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _InfoCard(
                          icon: Icons.people_alt_outlined,
                          title: doctor.patients,
                          subtitle: "Patients",
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month),
                      label: const Text(
                        "Book Appointment",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
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

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: color,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _Doctor {
  final String name;
  final String speciality;
  final String experience;
  final double rating;
  final String patients;
  final Color color;

  const _Doctor({
    required this.name,
    required this.speciality,
    required this.experience,
    required this.rating,
    required this.patients,
    required this.color,
  });
}