import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/challenge_provider.dart';
import '../services/permission_service.dart';
import 'step_tracker_screen.dart';

class HealthChallengesScreen extends StatefulWidget {
  const HealthChallengesScreen({super.key});

  @override
  State<HealthChallengesScreen> createState() =>
      _HealthChallengesScreenState();
}

class _HealthChallengesScreenState
    extends State<HealthChallengesScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ChallengeProvider>().loadChallenges();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeProvider>(
      builder: (context, provider, child) {

        return Scaffold(
          backgroundColor: const Color(0xffF5F7FB),

          appBar: AppBar(
            title: const Text("Health Challenges"),
            centerTitle: true,
          ),

          body: provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      /// Dashboard
                      Row(
                        children: [

                          Expanded(
                            child: _dashboardCard(
                              Icons.favorite,
                              Colors.red,
                              "Health Points",
                              "0",
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _dashboardCard(
                              Icons.local_fire_department,
                              Colors.orange,
                              "Streak",
                              "0",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [

                          Expanded(
                            child: _dashboardCard(
                              Icons.check_circle,
                              Colors.green,
                              "Completed",
                              "0",
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _dashboardCard(
                              Icons.flag,
                              Colors.blue,
                              "Active",
                              provider.challenges.length
                                  .toString(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "My Challenges",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount:
                            provider.challenges.length,
                        itemBuilder: (context, index) {

                          final challenge =
                              provider.challenges[index];

                          return Card(
                            elevation: 3,
                            margin:
                                const EdgeInsets.only(
                              bottom: 16,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [

                                  Row(
                                    children: [

                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.green
                                                .shade100,
                                        child: const Icon(
                                          Icons
                                              .emoji_events,
                                          color:
                                              Colors.green,
                                        ),
                                      ),

                                      const SizedBox(
                                          width: 12),

                                      Expanded(
                                        child: Text(
                                          challenge.title,
                                          style:
                                              const TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 12),

                                  Text(
                                    challenge.description,
                                  ),

                                  const SizedBox(
                                      height: 16),

                                  LinearProgressIndicator(
                                    value: 0,
                                    minHeight: 8,
                                    borderRadius:
                                        BorderRadius
                                            .circular(8),
                                  ),

                                  const SizedBox(
                                      height: 10),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons.flag,
                                        color:
                                            Colors.blue,
                                        size: 20,
                                      ),

                                      const SizedBox(
                                          width: 6),

                                      Text(
                                        "${challenge.target} ${challenge.unit}",
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons
                                            .workspace_premium,
                                        color:
                                            Colors.orange,
                                        size: 20,
                                      ),

                                      const SizedBox(
                                          width: 6),

                                      Text(
                                        "${challenge.rewardPoints} Health Points",
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 18),

                                  SizedBox(
                                    width:
                                        double.infinity,
                                    child: FilledButton
                                        .icon(
                                      icon: const Icon(
                                          Icons.play_arrow),
                                      label: const Text(
                                          "Start Challenge"),
                                      onPressed:
                                          () async {

                                        try {

                                          final permission =
                                              PermissionService();

                                          final granted =
                                              await permission
                                                  .requestActivityPermission();

                                          if (!granted) {

                                            if (!mounted) {
                                              return;
                                            }

                                            ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text(
                                                  "Activity permission required.",
                                                ),
                                              ),
                                            );

                                            return;
                                          }

                                          await provider
                                              .joinChallenge(
                                            challenge.id,
                                          );

                                          if (!mounted) {
                                            return;
                                          }

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) =>
                                                      StepTrackerScreen(
                                                challengeId:
                                                    challenge.id,
                                                challengeTitle:
                                                    challenge.title,
                                                targetSteps:
                                                    challenge.target,
                                              ),
                                            ),
                                          );

                                        } catch (e) {

                                          debugPrint(
                                            e.toString(),
                                          );

                                          if (!mounted) {
                                            return;
                                          }

                                          ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text(
                                                e.toString(),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _dashboardCard(
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 32,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(title),
          ],
        ),
      ),
    );
  }
}