import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/achievement_model.dart';
import '../services/mock_achievement_service.dart';

final achievementsProvider = Provider<List<AchievementModel>>((ref) {
  return MockAchievementService.getAchievements();
});
