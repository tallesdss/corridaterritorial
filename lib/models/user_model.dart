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
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profilePicture,
    int? totalDistanceMetres,
    int? level,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      totalDistanceMetres: totalDistanceMetres ?? this.totalDistanceMetres,
      level: level ?? this.level,
    );
  }
}
