import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosticBookingService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> bookDiagnostic({
    required String patientName,
    required String phoneNumber,
    required String centerName,
    required String testName,
    required String price,
    required DateTime bookingDate,
    required String bookingTime,
    required bool homeCollection,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _supabase.from('diagnostic_bookings').insert({
      'user_id': user.id,
      'patient_name': patientName,
      'phone_number': phoneNumber,
      'center_name': centerName,
      'test_name': testName,
      'price': price,
      'booking_date': bookingDate.toIso8601String().split('T')[0],
      'booking_time': bookingTime,
      'home_collection': homeCollection,
      'status': 'Upcoming',
    });
  }
}