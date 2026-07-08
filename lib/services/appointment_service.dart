
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> bookAppointment({
    required String patientName,
    required String doctorName,
    required String specialization,
    required DateTime appointmentDate,
    required String appointmentTime,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _supabase.from('appointments').insert({
      'user_id': user.id,
      'patient_name': patientName,
      'doctor_name': doctorName,
      'specialization': specialization,
      'appointment_date': appointmentDate.toIso8601String().split('T')[0],
      'appointment_time': appointmentTime,
      'status': 'Upcoming',
    });
  }
}