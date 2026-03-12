import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/supabase_auth_service.dart';
import 'dart:async';

final authServiceProvider = Provider<AuthService>((ref) {
  return SupabaseAuthService();
});

class AuthNotifier extends Notifier<AsyncValue<UserModel?>> {
  StreamSubscription<UserModel?>? _authStateSubscription;

  @override
  AsyncValue<UserModel?> build() {
    final authService = ref.watch(authServiceProvider);
    
    // Escuta mudanças no estado de autenticação
    _authStateSubscription?.cancel();
    _authStateSubscription = authService.onAuthStateChanged.listen((user) {
      state = AsyncValue.data(user);
    });

    ref.onDispose(() {
      _authStateSubscription?.cancel();
    });

    // Estado inicial
    return AsyncValue.data(authService.currentUser);
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(authServiceProvider).signIn(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(authServiceProvider).signUp(name, email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> resetPassword(String email) async {
     await ref.read(authServiceProvider).resetPassword(email);
  }

  Future<void> updateProfile({String? name, String? profilePicture}) async {
    final currentUser = state.value;
    if (currentUser != null) {
      // Atualiza via serviço (Postgres)
      await ref.read(authServiceProvider).updateProfile(
        name: name,
        profilePicture: profilePicture,
      );
      // Atualiza logalmente enquanto o stream nao reemite
      state = AsyncValue.data(currentUser.copyWith(
        name: name,
        profilePicture: profilePicture,
      ));
    }
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();
    await ref.read(authServiceProvider).logOut();
    state = const AsyncValue.data(null);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AsyncValue<UserModel?>>(() {
  return AuthNotifier();
});

