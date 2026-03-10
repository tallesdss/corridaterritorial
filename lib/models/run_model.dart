import 'package:flutter/material.dart';

class RunModel {
  final String id;
  final DateTime date;
  final double distanceKm;
  final Duration duration;
  final double calories;
  final double pace; // min/km
  final String title;

  RunModel({
    required this.id,
    required this.date,
    required this.distanceKm,
    required this.duration,
    required this.calories,
    required this.pace,
    required this.title,
  });

  String get formattedDate {
    return "${date.day}/${date.month}/${date.year}";
  }

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String get formattedDistance {
    return "${distanceKm.toStringAsFixed(2)} km";
  }

  String get formattedPace {
    return "${pace.toStringAsFixed(2)} min/km";
  }
}
