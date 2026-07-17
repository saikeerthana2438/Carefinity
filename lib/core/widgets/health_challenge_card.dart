import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/health_challenges/providers/challenge_provider.dart';
import '../../features/health_challenges/screens/health_challenges_screen.dart';

class HealthChallengeCard extends StatelessWidget {
  const HealthChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HealthChallengesScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green.shade100,
                child: const Icon(
                  Icons.directions_walk,
                  size: 30,
                  color: Colors.green,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text(
        "🏆 Health Challenges",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 8),

      Row(
        children: [

          Icon(
            Icons.local_fire_department,
            color: Colors.orange.shade700,
            size: 18,
          ),

          const SizedBox(width: 5),

          const Text(
            "6 Active Challenges",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),

      const SizedBox(height: 6),

      Row(
        children: [

          Icon(
            Icons.favorite,
            color: Colors.red.shade400,
            size: 18,
          ),

          const SizedBox(width: 5),

          const Text(
            "Earn Health Points",
          ),
        ],
      ),

      const SizedBox(height: 8),

      Text(
        "Walk • Water • Sleep • Yoga • Diet • Medication",
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
    ],
  ),
),

              Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Icon(
    Icons.arrow_forward,
    color: Colors.green,
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}