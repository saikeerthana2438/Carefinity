import 'dart:async';

import 'package:pedometer/pedometer.dart';

class StepTrackerService {
  StreamSubscription<StepCount>? _subscription;

  Function(int)? onStepChanged;

  void startTracking() {
  print("Starting Step Tracker...");

  _subscription = Pedometer.stepCountStream.listen(
    (StepCount event) {
      print("Raw Sensor: ${event.steps}");
      onStepChanged?.call(event.steps);
    },
    onError: (error) {
      print("=================================");
      print("Step Counter Error: $error");
      print("=================================");
    },
  );
}

  void stopTracking() {
    _subscription?.cancel();
  }
}