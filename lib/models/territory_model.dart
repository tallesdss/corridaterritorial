class TerritoryModel {
  final String id;
  final String name;
  final String currentOwnerName;
  final String currentOwnerAvatar;
  final double areaSqKm;
  final int totalBattles;
  final DateTime lastCaptured;
  final List<String> history; // History of owners

  TerritoryModel({
    required this.id,
    required this.name,
    required this.currentOwnerName,
    required this.currentOwnerAvatar,
    required this.areaSqKm,
    this.totalBattles = 0,
    required this.lastCaptured,
    required this.history,
  });
}
