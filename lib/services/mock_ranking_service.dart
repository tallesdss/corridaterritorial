import '../models/ranked_user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockRankingServiceProvider = Provider((ref) => MockRankingService());

class MockRankingService {
  final List<RankedUserModel> _users = [
    RankedUserModel(id: '1', name: 'Miguel', territoryScore: 1250, distanceKm: 42.5, achievements: 15, avatarUrl: 'https://i.pravatar.cc/150?u=1'),
    RankedUserModel(id: '2', name: 'Laura', territoryScore: 1100, distanceKm: 55.0, achievements: 18, avatarUrl: 'https://i.pravatar.cc/150?u=2'),
    RankedUserModel(id: '3', name: 'Carlos', territoryScore: 950, distanceKm: 38.2, achievements: 10, avatarUrl: 'https://i.pravatar.cc/150?u=3'),
    RankedUserModel(id: '4', name: 'Ana', territoryScore: 880, distanceKm: 29.5, achievements: 8, avatarUrl: 'https://i.pravatar.cc/150?u=4'),
    RankedUserModel(id: '5', name: 'Pedro', territoryScore: 720, distanceKm: 80.1, achievements: 25, avatarUrl: 'https://i.pravatar.cc/150?u=5'),
    RankedUserModel(id: '6', name: 'Sofia', territoryScore: 650, distanceKm: 15.0, achievements: 5, avatarUrl: 'https://i.pravatar.cc/150?u=6'),
    RankedUserModel(id: '7', name: 'João', territoryScore: 500, distanceKm: 10.0, achievements: 2, avatarUrl: 'https://i.pravatar.cc/150?u=7'),
    RankedUserModel(id: '8', name: 'Maria', territoryScore: 450, distanceKm: 12.0, achievements: 3, avatarUrl: 'https://i.pravatar.cc/150?u=8'),
    RankedUserModel(id: '9', name: 'Lucas', territoryScore: 300, distanceKm: 5.0, achievements: 1, avatarUrl: 'https://i.pravatar.cc/150?u=9'),
    RankedUserModel(id: '10', name: 'Julia', territoryScore: 250, distanceKm: 8.0, achievements: 2, avatarUrl: 'https://i.pravatar.cc/150?u=10'),
    RankedUserModel(id: '11', name: 'Eu (Você)', territoryScore: 850, distanceKm: 35.0, achievements: 12, avatarUrl: null),
  ];

  Future<List<RankedUserModel>> getRankingByTerritory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final sorted = List<RankedUserModel>.from(_users);
    sorted.sort((a, b) => b.territoryScore.compareTo(a.territoryScore));
    return sorted;
  }

  Future<List<RankedUserModel>> getRankingByDistance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final sorted = List<RankedUserModel>.from(_users);
    sorted.sort((a, b) => b.distanceKm.compareTo(a.distanceKm));
    return sorted;
  }

  Future<List<RankedUserModel>> getRankingByAchievements() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final sorted = List<RankedUserModel>.from(_users);
    sorted.sort((a, b) => b.achievements.compareTo(a.achievements));
    return sorted;
  }
}
