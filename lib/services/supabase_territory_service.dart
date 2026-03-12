import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTerritoryService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getTerritoriesInViewport(
    double minLat, double minLng, double maxLat, double maxLng
  ) async {
    // Usando RPC para busca espacial eficiente
    // Precisamos criar essa função no Postgres (st_intersects)
    try {
      final response = await _supabase.rpc(
        'get_territories_in_view',
        params: {
          'min_lat': minLat,
          'min_lng': minLng,
          'max_lat': maxLat,
          'max_lng': maxLng,
        },
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Erro ao buscar territórios: $e');
      return [];
    }
  }

  // Fallback se não quiser usar RPC agora, mas RPC é melhor para PostGIS
}
