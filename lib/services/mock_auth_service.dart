import '../models/user_model.dart';
import 'dart:async';

class MockAuthService {
  Future<UserModel> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Pequeno delay para UX
    return UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Corredor Convidado',
      email: email,
      level: 1,
      totalDistanceMetres: 0,
    );
  }

  Future<UserModel> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: 'user_new',
      name: name,
      email: email,
    );
  }

  Future<void> logOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
