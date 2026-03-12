import 'package:flutter/material.dart';
import '../models/achievement_model.dart';

class MockAchievementService {
  static List<AchievementModel> getAchievements() {
    return [
      AchievementModel(
        id: '1',
        title: 'Primeira Passada',
        description: 'Complete sua primeira corrida.',
        icon: Icons.directions_run,
        color: Colors.green,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 30)),
        progress: 1.0,
        category: AchievementCategory.frequency,
      ),
      AchievementModel(
        id: '2',
        title: 'Velocista',
        description: 'Alcance um pace abaixo de 5:00 min/km.',
        icon: Icons.flash_on,
        color: Colors.orange,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 15)),
        progress: 1.0,
        category: AchievementCategory.speed,
      ),
      AchievementModel(
        id: '3',
        title: 'Explorador Urbano',
        description: 'Conquiste 10 territórios diferentes.',
        icon: Icons.map,
        color: Colors.blue,
        isUnlocked: false,
        progress: 0.7,
        category: AchievementCategory.territory,
      ),
      AchievementModel(
        id: '4',
        title: 'Maratonista',
        description: 'Acumule um total de 42km percorridos.',
        icon: Icons.emoji_events,
        color: Colors.amber,
        isUnlocked: false,
        progress: 0.45,
        category: AchievementCategory.distance,
      ),
      AchievementModel(
        id: '5',
        title: 'Madrugador',
        description: 'Complete 5 corridas antes das 7h da manhã.',
        icon: Icons.wb_sunny,
        color: Colors.deepOrange,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 2)),
        progress: 1.0,
        category: AchievementCategory.frequency,
      ),
      AchievementModel(
        id: '6',
        title: 'Guerreiro de Final de Semana',
        description: 'Corra em 4 finais de semana seguidos.',
        icon: Icons.calendar_today,
        color: Colors.purple,
        isUnlocked: false,
        progress: 0.5,
        category: AchievementCategory.frequency,
      ),
    ];
  }
}
