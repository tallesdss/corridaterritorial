import '../models/user_model.dart';
import 'dart:async';

class MockAuthService {
  Future<UserModel> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    if (email == 'user@test.com' && password == 'password123') {
      return UserModel(
        id: 'user_1',
        name: 'Runner Zero',
        email: email,
        level: 5,
        totalDistanceMetres: 120500,
      );
    }
    throw Exception('Credenciais inválidas');
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
