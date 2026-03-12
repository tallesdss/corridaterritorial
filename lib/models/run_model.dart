
class RunModel {
  final String id;
  final String? userId;
  final DateTime date;
  final double distanceKm;
  final Duration duration;
  final double calories;
  final double pace; // min/km
  final String? title;
  final String? polyPath; // Formato GeoJSON ou Polyline string

  RunModel({
    required this.id,
    this.userId,
    required this.date,
    required this.distanceKm,
    required this.duration,
    required this.calories,
    required this.pace,
    this.title,
    this.polyPath,
  });

  factory RunModel.fromJson(Map<String, dynamic> json) {
    return RunModel(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['created_at'] ?? json['date']),
      distanceKm: (json['distance'] ?? json['distanceKm']).toDouble(),
      duration: Duration(seconds: json['duration'] is int ? json['duration'] : (json['duration'] as double).toInt()),
      calories: (json['calories'] ?? 0).toDouble(),
      pace: (json['pace'] ?? 0).toDouble(),
      title: json['title'],
      polyPath: json['poly_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      'distance': distanceKm,
      'duration': duration.inSeconds,
      'pace': pace,
      'calories': calories,
      'poly_path': polyPath,
      'created_at': date.toIso8601String(),
    };
  }

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
