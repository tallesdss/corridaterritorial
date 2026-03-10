import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/mock_auth_service.dart';

final mockAuthServiceProvider = Provider<MockAuthService>((ref) {
  return MockAuthService();
});

class AuthNotifier extends Notifier<AsyncValue<UserModel?>> {
  @override
  AsyncValue<UserModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(mockAuthServiceProvider).signIn(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(mockAuthServiceProvider).signUp(name, email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> resetPassword(String email) async {
     await ref.read(mockAuthServiceProvider).resetPassword(email);
  }

  Future<void> updateProfile({String? name, String? profilePicture}) async {
    final currentUser = state.value;
    if (currentUser != null) {
      state = AsyncValue.data(currentUser.copyWith(
        name: name,
        profilePicture: profilePicture,
      ));
    }
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();
    await ref.read(mockAuthServiceProvider).logOut();
    state = const AsyncValue.data(null);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AsyncValue<UserModel?>>(() {
  return AuthNotifier();
});
