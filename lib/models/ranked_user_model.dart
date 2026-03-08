class RankedUserModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final int territoryScore;
  final double distanceKm;
  final int achievements;

  RankedUserModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.territoryScore,
    required this.distanceKm,
    required this.achievements,
  });
}
