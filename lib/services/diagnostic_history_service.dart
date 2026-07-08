import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosticHistoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getBookings() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return [];
    }

    final response = await _supabase
        .from('diagnostic_bookings')
        .select()
        .eq('user_id', user.id)
        .order('booking_date', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }
}