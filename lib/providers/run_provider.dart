import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/run_model.dart';
import '../services/mock_run_service.dart';

final mockRunServiceProvider = Provider<MockRunService>((ref) {
  return MockRunService();
});

final runsProvider = FutureProvider<List<RunModel>>((ref) async {
  final service = ref.watch(mockRunServiceProvider);
  return service.getRuns();
});
