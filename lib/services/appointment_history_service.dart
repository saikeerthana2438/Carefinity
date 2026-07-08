import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentHistoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAppointments() async {
  final user = _supabase.auth.currentUser;

  if (user == null) {
    print("No logged in user");
    return [];
  }

  print("Current User ID: ${user.id}");

  final response = await _supabase
      .from('appointments')
      .select()
      .eq('user_id', user.id)
      .order('appointment_date', ascending: true);

  print("Appointments from Supabase:");
  print(response);

  return List<Map<String, dynamic>>.from(response);
}
}