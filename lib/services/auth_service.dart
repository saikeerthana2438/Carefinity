import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Sign Up
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Login
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Logout
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Current User
  User? get currentUser => _supabase.auth.currentUser;

  /// Is Logged In
  bool get isLoggedIn => currentUser != null;

  /// Listen for Auth Changes
  Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;
}