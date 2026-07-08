import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.calendar_month,
        color: Colors.blue,
        size: 30,
      ),
    ),

    const SizedBox(width: 14),

    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dr. Sarah Johnson",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          Text(
            "Cardiologist",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: Colors.blue,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Tomorrow • 10:30 AM",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),

    const SizedBox(width: 8),

    SizedBox(
      height: 38,
      child: FilledButton(
        onPressed: () {},
        child: const Text("View"),
      ),
    ),
  ],
)
      ),
    );
  }
}