import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportService {
  final SupabaseClient _supabase = Supabase.instance.client;

  static const String bucket = 'medical-reports';

  // =======================
  // Upload Report
  // =======================
  Future<void> uploadReport({
    required File file,
    required String reportName,
    required String hospitalName,
    required String reportType,
    required DateTime reportDate,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final fileName =
        "${user.id}/${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}";

    await _supabase.storage
        .from(bucket)
        .upload(
          fileName,
          file,
          fileOptions: const FileOptions(
            upsert: false,
          ),
        );

    await _supabase.from('medical_reports').insert({
      'user_id': user.id,
      'report_name': reportName,
      'hospital_name': hospitalName,
      'report_type': reportType,
      'report_date': reportDate.toIso8601String().split('T')[0],
      'file_url': fileName,
    });
  }

  // =======================
  // Get Reports
  // =======================
  Future<List<Map<String, dynamic>>> getReports() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('medical_reports')
        .select()
        .eq('user_id', user.id)
        .order('uploaded_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // =======================
  // Signed URL
  // =======================
  Future<String> getSignedUrl(String filePath) async {
    return await _supabase.storage
        .from(bucket)
        .createSignedUrl(filePath, 3600);
  }

  // =======================
  // Delete Report
  // =======================
  Future<void> deleteReport({
    required String id,
    required String filePath,
  }) async {
    await _supabase.storage
        .from(bucket)
        .remove([filePath]);

    await _supabase
        .from('medical_reports')
        .delete()
        .eq('id', id);
  }
}