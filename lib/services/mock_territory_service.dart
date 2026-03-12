import '../models/territory_model.dart';

class MockTerritoryService {
  static TerritoryModel getMockTerritory() {
    return TerritoryModel(
      id: 'area-51',
      name: 'Parque do Ibirapuera',
      currentOwnerName: 'Rafael Silva',
      currentOwnerAvatar: 'https://i.pravatar.cc/150?u=rafael',
      areaSqKm: 1.58,
      totalBattles: 24,
      lastCaptured: DateTime.now().subtract(const Duration(days: 3)),
      history: ['Ana Santos', 'Bruno Lima', 'Rafael Silva'],
    );
  }
}
