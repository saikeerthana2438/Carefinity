import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/challenge_model.dart';

class ChallengeRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetch all challenges
  Future<List<ChallengeModel>> getChallenges() async {
    final response = await _supabase
        .from('health_challenges')
        .select()
        .order('target');

    return response
        .map<ChallengeModel>(
          (e) => ChallengeModel.fromMap(e),
        )
        .toList();
  }

  /// Join a challenge
  Future<void> joinChallenge({
  required String challengeId,
  required String userId,
}) async {

  final existing = await _supabase
      .from('user_challenges')
      .select()
      .eq('user_id', userId)
      .eq('challenge_id', challengeId);

  if (existing.isNotEmpty) {
    return;
  }

  await _supabase.from('user_challenges').insert({
    'user_id': userId,
    'challenge_id': challengeId,
    'progress': 0,
    'completed': false,
    'streak': 0,
  });
}

  /// Update progress
  Future<void> updateProgress({
    required String challengeId,
    required String userId,
    required int progress,
  }) async {
    await _supabase
        .from('user_challenges')
        .update({
          'progress': progress,
        })
        .eq('challenge_id', challengeId)
        .eq('user_id', userId);
  }

   Future<int> getProgress({
  required String challengeId,
  required String userId,
}) async {
  final response = await _supabase
      .from('user_challenges')
      .select('progress')
      .eq('challenge_id', challengeId)
      .eq('user_id', userId)
      .maybeSingle();

  if (response == null) {
    return 0;
  }

  return response['progress'] ?? 0;
}

  /// Complete challenge
  Future<void> completeChallenge({
    required String challengeId,
    required String userId,
  }) async {
    await _supabase
        .from('user_challenges')
        .update({
          'completed': true,
        })
        .eq('challenge_id', challengeId)
        .eq('user_id', userId);
  }
}