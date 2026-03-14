import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa variáveis de ambiente
  await dotenv.load(fileName: ".env");

  // Inicializa Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  
  // Inicializa Mapbox
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_PUBLIC_TOKEN'] ?? '');

  runApp(
    const ProviderScope(
      child: CorridaTerritorialApp(),
    ),
  );
}

class CorridaTerritorialApp extends ConsumerWidget {
  const CorridaTerritorialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Corrida Territorial',
      theme: AppTheme.darkTheme, // Forçando darkTheme como padrão
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
