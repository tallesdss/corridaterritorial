import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/achievement_model.dart';
import '../providers/auth_provider.dart';

final achievementServiceProvider = Provider((ref) {
  final authState = ref.watch(authProvider);
  return AchievementService(Supabase.instance.client, authState.value?.id);
});

class AchievementService {
  final SupabaseClient _supabase;
  final String? _userId;

  AchievementService(this._supabase, this._userId);

  Future<List<AchievementModel>> getAchievements() async {
    if (_userId == null) {
      return [];
    }

    // Busca todas as conquistas do sistema
    final achievementsResponse = await _supabase.from('achievements').select();
    
    // Busca o progresso do usuário atual
    final userAchievementsResponse = await _supabase
        .from('user_achievements')
        .select()
        .eq('user_id', _userId);

    final userAchievementsMap = {
      for (var item in userAchievementsResponse)
        item['achievement_id'] as String: item
    };

    return achievementsResponse.map((json) {
      final id = json['id'] as String;
      final userAcv = userAchievementsMap[id];
      
      final targetValue = (json['target_value'] as num).toDouble();
      final progressValue = (userAcv?['progress_value'] as num?)?.toDouble() ?? 0.0;
      
      // Limita progresso a 1.0 (100%)
      final double progress = (progressValue / targetValue).clamp(0.0, 1.0);
      final isUnlocked = userAcv?['is_unlocked'] as bool? ?? false;
      
      DateTime? unlockedAt;
      if (userAcv?['unlocked_at'] != null) {
        unlockedAt = DateTime.parse(userAcv!['unlocked_at'] as String).toLocal();
      }

      return AchievementModel(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        icon: _parseIcon(json['icon_name'] as String),
        color: _parseColor(json['color_hex'] as String),
        isUnlocked: isUnlocked,
        unlockedAt: unlockedAt,
        progress: progress,
        category: _parseCategory(json['category'] as String),
      );
    }).toList();
  }

  IconData _parseIcon(String iconName) {
    switch (iconName) {
      case 'directions_run':
        return Icons.directions_run;
      case 'flash_on':
        return Icons.flash_on;
      case 'map':
        return Icons.map;
      case 'emoji_events':
        return Icons.emoji_events;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'calendar_today':
        return Icons.calendar_today;
      default:
        return Icons.star;
    }
  }

  Color _parseColor(String colorHex) {
    try {
      return Color(int.parse(colorHex, radix: 16));
    } catch (e) {
      return Colors.blue; 
    }
  }

  AchievementCategory _parseCategory(String category) {
    switch (category) {
      case 'distance':
        return AchievementCategory.distance;
      case 'frequency':
        return AchievementCategory.frequency;
      case 'speed':
        return AchievementCategory.speed;
      case 'territory':
        return AchievementCategory.territory;
      default:
        return AchievementCategory.distance;
    }
  }
}
