import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/health_points_provider.dart';

class HealthPointsCard extends StatelessWidget {
  const HealthPointsCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<HealthPointsProvider>(
      builder: (_, provider, __) {

        if (provider.loading) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [

                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 40,
                ),

                const SizedBox(width: 15),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Health Points",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      "${provider.points}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}