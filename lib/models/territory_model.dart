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

  factory TerritoryModel.example() {
    return TerritoryModel(
      id: 'example-id',
      name: 'Parque Ibirapuera',
      currentOwnerName: 'Atleta Pro',
      currentOwnerAvatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&h=200&fit=crop',
      areaSqKm: 1.2,
      totalBattles: 42,
      lastCaptured: DateTime.now().subtract(const Duration(hours: 3)),
      history: ['Atleta Pro', 'Corredor Virtual', 'Mestre das Trilhas'],
    );
  }
}
