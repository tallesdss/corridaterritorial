import 'package:flutter/material.dart';

enum AchievementCategory { distance, frequency, speed, territory }

class AchievementModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final double progress; // 0.0 to 1.0
  final AchievementCategory category;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0.0,
    required this.category,
  });
}
