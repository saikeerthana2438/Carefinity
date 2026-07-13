import 'package:flutter/material.dart';
import 'challenge_model.dart';

class ChallengeCard extends StatelessWidget {

  final Challenge challenge;
  final VoidCallback onPressed;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.all(10),

      child: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            Text(
              "${challenge.icon} ${challenge.title}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: challenge.percentage,
            ),

            const SizedBox(height: 10),

            Text(
              "${challenge.progress}/${challenge.goal}",
            ),

            const SizedBox(height: 10),

            ElevatedButton(

              onPressed: challenge.completed
                  ? null
                  : onPressed,

              child: Text(
                challenge.completed
                    ? "Completed"
                    : "Update Progress",
              ),
            )
          ],
        ),
      ),
    );
  }
}