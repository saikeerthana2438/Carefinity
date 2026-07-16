import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cycle_model.dart';

class CycleService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Save a new menstrual cycle
  Future<void> saveCycle(CycleModel cycle) async {
    await _supabase.from('menstrual_cycles').insert(cycle.toMap());
  }

  /// Get all cycles of the current user
  Future<List<CycleModel>> getCycles() async {
    final response = await _supabase
        .from('menstrual_cycles')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => CycleModel.fromMap(item))
        .toList();
  }

  /// Update an existing cycle
  Future<void> updateCycle(CycleModel cycle) async {
    await _supabase
        .from('menstrual_cycles')
        .update(cycle.toMap())
        .eq('id', cycle.id!);
  }

  /// Delete a cycle
  Future<void> deleteCycle(String id) async {
    await _supabase
        .from('menstrual_cycles')
        .delete()
        .eq('id', id);
  }
}