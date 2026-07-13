import 'package:flutter/material.dart';

import 'challenge_service.dart';
import 'challenge_card.dart';
import 'badge_widget.dart';

class ChallengeScreen extends StatefulWidget {

  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {

  final ChallengeService service = ChallengeService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Health Challenges"),
      ),

      body: ListView(

        children: [

          const SizedBox(height: 20),

          Center(

            child: Text(

              "🔥 Current Streak : ${service.streak} Days",

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...service.challenges.map(

            (challenge)=>ChallengeCard(

              challenge: challenge,

              onPressed: (){

                setState(() {

                  service.updateProgress(challenge,1);

                });

              },

            ),

          ),

          const SizedBox(height: 20),

          const Padding(

            padding: EdgeInsets.all(12),

            child: Text(

              "Your Badges",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),

            ),
          ),

          Padding(

            padding: const EdgeInsets.all(10),

            child: BadgeWidget(
              badges: service.badges,
            ),
          )
        ],
      ),
    );
  }
}