import 'package:flutter/material.dart';

import '../repositories/health_points_repository.dart';

class HealthPointsProvider extends ChangeNotifier {

  final HealthPointsRepository _repository =
      HealthPointsRepository();

  int points = 0;

  bool loading = true;

  Future<void> loadPoints() async {

    loading = true;
    notifyListeners();

    final data = await _repository.getHealthPoints();

    points = data.points;

    loading = false;

    notifyListeners();
  }

  Future<void> addPoints(int value) async {

    await _repository.addPoints(value);

    await loadPoints();
  }
}