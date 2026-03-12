import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/achievement_model.dart';
import '../services/achievement_service.dart';

final achievementsFutureProvider = FutureProvider<List<AchievementModel>>((ref) async {
  final service = ref.watch(achievementServiceProvider);
  return await service.getAchievements();
});
