import 'package:supabase_flutter/supabase_flutter.dart';

class MedicationService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addMedication({
    required String medicineName,
    required String dosage,
    required String frequency,
    required String reminderTime,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _supabase.from('medications').insert({
      'user_id': user.id,
      'medicine_name': medicineName,
      'dosage': dosage,
      'frequency': frequency,
      'reminder_time': reminderTime,
      'start_date': startDate.toIso8601String().split('T')[0],
      'end_date': endDate.toIso8601String().split('T')[0],
    });
  }

  Future<List<Map<String, dynamic>>> getMedications() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('medications')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> deleteMedication(String id) async {
    await _supabase
        .from('medications')
        .delete()
        .eq('id', id);
  }
}