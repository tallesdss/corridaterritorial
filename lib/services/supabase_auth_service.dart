import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import '../models/user_model.dart';
import 'auth_service.dart';

class SupabaseAuthService implements AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Stream<UserModel?> get onAuthStateChanged {
    return _supabase.auth.onAuthStateChange.asyncMap((data) async {
      final user = data.session?.user;
      return user != null ? await _mapToUserModelAsync(user) : null;
    });
  }

  @override
  UserModel? get currentUser {
    final user = _supabase.auth.currentUser;
    // Retorna sincrono mas os dados reais serão populados via stream logo em seguida.
    return user != null ? _mapToUserModelSync(user) : null;
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user != null ? await _mapToUserModelAsync(response.user!) : null;
  }

  @override
  Future<UserModel?> signUp(String name, String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': name},
    );
    return response.user != null ? await _mapToUserModelAsync(response.user!) : null;
  }

  @override
  Future<void> logOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updateProfile({String? name, String? profilePicture}) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final Map<String, dynamic> updates = {};
    if (name != null) updates['username'] = name;
    
    if (profilePicture != null) {
      if (!profilePicture.startsWith('http')) {
        // It's a local file path, upload it to storage
        try {
          final fileExt = profilePicture.split('.').last;
          final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
          
          await _supabase.storage.from('avatars').upload(
                fileName,
                File(profilePicture),
                fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
              );
              
          final String publicUrl = _supabase.storage.from('avatars').getPublicUrl(fileName);
          updates['avatar_url'] = publicUrl;
        } catch (e) {
          // ignore for now if storage fails
        }
      } else {
        updates['avatar_url'] = profilePicture;
      }
    }

    if (updates.isNotEmpty) {
      await _supabase.from('profiles').update(updates).eq('id', user.id);
    }
  }

  UserModel _mapToUserModelSync(User user) {
    return UserModel(
      id: user.id,
      name: user.userMetadata?['display_name'] ?? user.email?.split('@')[0] ?? 'Corredor',
      email: user.email ?? '',
    );
  }

  Future<UserModel> _mapToUserModelAsync(User user) async {
    try {
      final profile = await _supabase.from('profiles').select().eq('id', user.id).maybeSingle();
      if (profile != null) {
        return UserModel(
          id: user.id,
          name: profile['username'] ?? user.userMetadata?['display_name'] ?? user.email?.split('@')[0] ?? 'Corredor',
          email: user.email ?? '',
          profilePicture: profile['avatar_url'],
          level: profile['level'] ?? 1,
        );
      }
    } catch (_) {}
    return _mapToUserModelSync(user);
  }
}
