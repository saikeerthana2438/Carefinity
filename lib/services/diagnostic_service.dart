import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosticService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> bookDiagnostic({
    required String testName,
    required String price,
    required DateTime bookingDate,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _supabase.from('diagnostic_bookings').insert({
      'user_id': user.id,
      'test_name': testName,
      'price': price,
      'booking_date': bookingDate.toIso8601String().split('T')[0],
      'status': 'Upcoming',
    });
  }

  Future<List<Map<String, dynamic>>> getDiagnostics() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('diagnostic_bookings')
        .select()
        .eq('user_id', user.id)
        .order('booking_date', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }
}