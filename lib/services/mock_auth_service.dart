import '../models/user_model.dart';
import 'dart:async';
import 'auth_service.dart';

class MockAuthService implements AuthService {
  final _authStateController = StreamController<UserModel?>.broadcast();

  @override
  Stream<UserModel?> get onAuthStateChanged => _authStateController.stream;

  @override
  UserModel? get currentUser => null;

  @override
  Future<UserModel?> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Pequeno delay para UX
    final user = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Corredor Convidado',
      email: email,
      level: 1,
      totalDistanceMetres: 0,
    );
    _authStateController.add(user);
    return user;
  }

  @override
  Future<UserModel?> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = UserModel(
      id: 'user_new',
      name: name,
      email: email,
    );
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _authStateController.add(null);
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> updateProfile({String? name, String? profilePicture}) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

