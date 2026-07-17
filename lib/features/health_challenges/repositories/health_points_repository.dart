import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/health_points_model.dart';

class HealthPointsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<HealthPointsModel> getHealthPoints() async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('user_health_points')
        .select()
        .eq('user_id', userId)
        .single();

    return HealthPointsModel.fromMap(response);
  }

  Future<void> addPoints(int value) async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('user_health_points')
        .select()
        .eq('user_id', userId)
        .single();

    final current = response['points'] ?? 0;

    await _supabase
        .from('user_health_points')
        .update({
          'points': current + value,
        })
        .eq('user_id', userId);
  }
}