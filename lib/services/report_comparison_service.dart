import 'package:supabase_flutter/supabase_flutter.dart';

class ReportComparisonService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> saveValue({
    required String reportId,
    required String testName,
    required double value,
    required String unit,
    required DateTime reportDate,
  }) async {
    final user = supabase.auth.currentUser;

    await supabase.from('report_values').insert({
      'user_id': user!.id,
      'report_id': reportId,
      'test_name': testName,
      'test_value': value,
      'unit': unit,
      'report_date': reportDate.toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getValues(String reportId) async {
    final data = await supabase
        .from('report_values')
        .select()
        .eq('report_id', reportId);

    return List<Map<String, dynamic>>.from(data);
  }
}