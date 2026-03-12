import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/run_model.dart';
import '../services/supabase_run_service.dart';

final runServiceProvider = Provider<SupabaseRunService>((ref) {
  return SupabaseRunService();
});

final runsProvider = FutureProvider<List<RunModel>>((ref) async {
  final service = ref.watch(runServiceProvider);
  return service.getRuns();
});
