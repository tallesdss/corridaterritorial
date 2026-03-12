import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/supabase_territory_service.dart';

final territoryServiceProvider = Provider<SupabaseTerritoryService>((ref) {
  return SupabaseTerritoryService();
});

// Provider para territórios visíveis no mapa
final visibleTerritoriesProvider = FutureProvider.family<List<Map<String, dynamic>>, List<double>>((ref, bbox) async {
  // bbox: [minLat, minLng, maxLat, maxLng]
  final service = ref.watch(territoryServiceProvider);
  return service.getTerritoriesInViewport(bbox[0], bbox[1], bbox[2], bbox[3]);
});
