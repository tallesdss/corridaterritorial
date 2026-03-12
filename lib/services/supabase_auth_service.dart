import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class SupabaseAuthService implements AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Stream<UserModel?> get onAuthStateChanged {
    return _supabase.auth.onAuthStateChange.map((data) {
      final user = data.session?.user;
      return user != null ? _mapToUserModel(user) : null;
    });
  }

  @override
  UserModel? get currentUser {
    final user = _supabase.auth.currentUser;
    return user != null ? _mapToUserModel(user) : null;
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user != null ? _mapToUserModel(response.user!) : null;
  }

  @override
  Future<UserModel?> signUp(String name, String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': name},
    );
    return response.user != null ? _mapToUserModel(response.user!) : null;
  }

  @override
  Future<void> logOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  UserModel _mapToUserModel(User user) {
    return UserModel(
      id: user.id,
      name: user.userMetadata?['display_name'] ?? user.email?.split('@')[0] ?? 'Corredor',
      email: user.email ?? '',
      // Outros campos como level e totalDistance virão da tabela profiles na Fase 2
      // Por enquanto, usamos os padrões do UserModel
    );
  }
}
