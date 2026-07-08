import 'package:supabase_flutter/supabase_flutter.dart';

class FamilyProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addProfile({
    required String name,
    required String relationship,
    required int age,
    required String gender,
    required String bloodGroup,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _supabase.from('family_profiles').insert({
      'user_id': user.id,
      'name': name,
      'relationship': relationship,
      'age': age,
      'gender': gender,
      'blood_group': bloodGroup,
    });
  }

  Future<List<Map<String, dynamic>>> getProfiles() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final response = await _supabase
        .from('family_profiles')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> deleteProfile(String id) async {
    await _supabase
        .from('family_profiles')
        .delete()
        .eq('id', id);
  }
}