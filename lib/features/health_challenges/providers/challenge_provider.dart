import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/challenge_model.dart';
import '../repositories/challenge_repository.dart';

class ChallengeProvider extends ChangeNotifier {
  final ChallengeRepository _repository = ChallengeRepository();

  final List<ChallengeModel> _challenges = [];

  bool _isLoading = false;

  List<ChallengeModel> get challenges => _challenges;

  bool get isLoading => _isLoading;

  /// Load all challenges
  Future<void> loadChallenges() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _repository.getChallenges();

      _challenges
        ..clear()
        ..addAll(data);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Join challenge
  Future<void> joinChallenge(String challengeId) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) return;

    await _repository.joinChallenge(
      challengeId: challengeId,
      userId: userId,
    );
  }
}