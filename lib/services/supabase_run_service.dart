import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/run_model.dart';

class SupabaseRunService {
  final _supabase = Supabase.instance.client;

  Future<List<RunModel>> getRuns() async {
    final response = await _supabase
        .from('runs')
        .select()
        .order('created_at', ascending: false);
    
    return (response as List).map((json) => RunModel.fromJson(json)).toList();
  }

  Future<void> addRun(RunModel run) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuário não autenticado');

    final data = run.toJson();
    data['user_id'] = userId;

    await _supabase.from('runs').insert(data);
  }
}
