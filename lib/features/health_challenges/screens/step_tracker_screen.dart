import 'package:flutter/material.dart';
import '../services/step_tracker_service.dart';
import '../services/permission_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/challenge_repository.dart';


class StepTrackerScreen extends StatefulWidget {
  final String challengeTitle;
  final String challengeId;
  final int targetSteps;

  const StepTrackerScreen({
  super.key,
  required this.challengeId,
  required this.challengeTitle,
  required this.targetSteps,
});

  @override
  State<StepTrackerScreen> createState() =>
      _StepTrackerScreenState();
}

class _StepTrackerScreenState
    extends State<StepTrackerScreen> {

  int currentSteps = 0;

  final StepTrackerService _tracker =
    StepTrackerService();

final PermissionService _permission =
    PermissionService();

    final ChallengeRepository _repository =
    ChallengeRepository();

final String userId =
    Supabase.instance.client.auth.currentUser!.id;

int savedProgress = 0;

int initialSteps = 0;
bool started = false;
bool challengeCompleted = false;

 @override
void initState() {
  super.initState();

  initializeTracker();
}

Future<void> initializeTracker() async {
  await loadSavedProgress();
  await startTracking();
}

Future<void> startTracking() async {
  final granted =
      await _permission.requestActivityPermission();

  if (!granted) return;

  _tracker.onStepChanged = (steps) async {

    // First reading after opening screen
    if (!started) {
      initialSteps = steps;
      started = true;
    }

    // Continue from previously saved progress
    currentSteps = savedProgress + (steps - initialSteps);

    if (mounted) {
      setState(() {});
    }

    // Save latest progress
    await _repository.updateProgress(
      challengeId: widget.challengeId,
      userId: userId,
      progress: currentSteps,
    );

    // Challenge completed
    if (!challengeCompleted &&
    currentSteps >= widget.targetSteps) {

  challengeCompleted = true;

  await _repository.completeChallenge(
    challengeId: widget.challengeId,
    userId: userId,
  );

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🎉 Challenge Completed!"),
      ),
    );
  }
}
  };

  _tracker.startTracking();
}

Future<void> loadSavedProgress() async {
  savedProgress = await _repository.getProgress(
    challengeId: widget.challengeId,
    userId: userId,
  );

  currentSteps = savedProgress;

  if (mounted) {
    setState(() {});
  }

  print("Saved Progress: $savedProgress");
}

  @override
  Widget build(BuildContext context) {

    final progress =
      (currentSteps / widget.targetSteps)
          .clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.challengeTitle),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            const Icon(
              Icons.directions_walk,
              size: 90,
              color: Colors.green,
            ),

            const SizedBox(height: 25),

            Text(
              "$currentSteps",
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Steps",
              style: TextStyle(
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: progress,
              minHeight: 14,
            ),

            const SizedBox(height: 12),

            Text(
              "$currentSteps / ${widget.targetSteps}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 40),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                  children: [

                    Column(
                      children: const [

                        Icon(Icons.local_fire_department),

                        SizedBox(height: 8),

                        Text("Calories"),

                        Text("0 kcal"),
                      ],
                    ),

                    Column(
                      children: const [

                        Icon(Icons.route),

                        SizedBox(height: 8),

                        Text("Distance"),

                        Text("0 km"),
                      ],
                    ),

                    Column(
                      children: const [

                        Icon(Icons.timer),

                        SizedBox(height: 8),

                        Text("Time"),

                        Text("0 min"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
@override
void dispose() {

  _tracker.stopTracking();

  super.dispose();
}

}