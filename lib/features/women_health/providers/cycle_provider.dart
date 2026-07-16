import 'package:flutter/material.dart';
import '../models/cycle_model.dart';
import '../services/cycle_service.dart';

class CycleProvider extends ChangeNotifier {
  final CycleService _service = CycleService();

  List<CycleModel> cycles = [];

  Future<void> loadCycles() async {
    cycles = await _service.getCycles();
    notifyListeners();
  }

  Future<void> addCycle(CycleModel cycle) async {
    await _service.saveCycle(cycle);
    await loadCycles();
    notifyListeners();
  }
  Future<void> updateCycle(CycleModel cycle) async {
  await _service.updateCycle(cycle);
  await loadCycles();
  notifyListeners();
}
Future<void> deleteCycle(String id) async {
  await _service.deleteCycle(id);

  cycles.removeWhere((cycle) => cycle.id == id);

  notifyListeners();
}
}