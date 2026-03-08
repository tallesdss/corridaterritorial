class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
  final int totalDistanceMetres;
  final int level;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.totalDistanceMetres = 0,
    this.level = 1,
  });
}
