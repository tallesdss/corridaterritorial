import '../models/user_model.dart';

abstract class AuthService {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String name, String email, String password);
  Future<void> logOut();
  Future<void> resetPassword(String email);
  Stream<UserModel?> get onAuthStateChanged;
  UserModel? get currentUser;
}
