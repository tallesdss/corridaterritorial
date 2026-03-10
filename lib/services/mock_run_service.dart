import '../models/run_model.dart';

class MockRunService {
  static final List<RunModel> _runs = [
    RunModel(
      id: '1',
      date: DateTime.now().subtract(const Duration(days: 1)),
      distanceKm: 5.2,
      duration: const Duration(minutes: 28, seconds: 45),
      calories: 420,
      pace: 5.5,
      title: 'Corrida Matinal no Parque',
    ),
    RunModel(
      id: '2',
      date: DateTime.now().subtract(const Duration(days: 3)),
      distanceKm: 3.5,
      duration: const Duration(minutes: 18, seconds: 12),
      calories: 280,
      pace: 5.2,
      title: 'Treino Rápido',
    ),
    RunModel(
      id: '3',
      date: DateTime.now().subtract(const Duration(days: 7)),
      distanceKm: 10.0,
      duration: const Duration(hours: 1, minutes: 2, seconds: 30),
      calories: 850,
      pace: 6.25,
      title: 'Longão de Domingo',
    ),
    RunModel(
      id: '4',
      date: DateTime.now().subtract(const Duration(days: 14)),
      distanceKm: 4.8,
      duration: const Duration(minutes: 25, seconds: 0),
      calories: 390,
      pace: 5.2,
      title: 'Corrida pós-trabalho',
    ),
    RunModel(
      id: '5',
      date: DateTime.now().subtract(const Duration(days: 20)),
      distanceKm: 7.2,
      duration: const Duration(minutes: 42, seconds: 15),
      calories: 610,
      pace: 5.8,
      title: 'Exploração de Novo Bairro',
    ),
  ];

  Future<List<RunModel>> getRuns() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network
    return List.from(_runs);
  }

  Future<void> addRun(RunModel run) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _runs.insert(0, run);
  }
}
