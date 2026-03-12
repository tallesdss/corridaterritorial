import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ranked_user_model.dart';

final rankingServiceProvider = Provider((ref) => RankingService(Supabase.instance.client));

class RankingService {
  final SupabaseClient _supabase;

  RankingService(this._supabase);

  Future<List<RankedUserModel>> getRankingByTerritory() async {
    final response = await _supabase
        .from('ranking_view')
        .select()
        .order('territories_count', ascending: false)
        .limit(100);

    return _mapResponse(response);
  }

  Future<List<RankedUserModel>> getRankingByDistance() async {
    final response = await _supabase
        .from('ranking_view')
        .select()
        .order('total_distance', ascending: false)
        .limit(100);

    return _mapResponse(response);
  }

  Future<List<RankedUserModel>> getRankingByAchievements() async {
    // Para simplificar agora, podemos ordenar pelo nível e xp
    // Como os achievements ainda serão implementados, vamos ordenar por XP
    final response = await _supabase
        .from('ranking_view')
        .select()
        .order('xp', ascending: false)
        .limit(100);

    return _mapResponse(response);
  }

  List<RankedUserModel> _mapResponse(List<dynamic> data) {
    return data.map((json) {
      return RankedUserModel(
        id: json['id'] as String,
        name: json['username'] as String? ?? 'Usuário',
        avatarUrl: json['avatar_url'] as String?,
        territoryScore: (json['territories_count'] as num?)?.toInt() ?? 0,
        distanceKm: (json['total_distance'] as num?)?.toDouble() ?? 0.0,
        achievements: 0, // Mock for now until achievements table is queryable
      );
    }).toList();
  }

  // Real-time subscription for the ranking view is technically not possible directly on a view without a trigger/publication workaround
  // But we can listen to the underlying 'profiles' and 'territories' tables
  Stream<List<Map<String, dynamic>>> watchProfiles() {
    return _supabase.from('profiles').stream(primaryKey: ['id']);
  }
}
