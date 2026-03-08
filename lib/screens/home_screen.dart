import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Corrida Territorial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logOut();
            },
          )
        ],
      ),
      body: Center(
        child: userState.when(
          data: (user) {
            if (user == null) return const CircularProgressIndicator();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 80, color: AppColors.success),
                const SizedBox(height: 20),
                Text(
                  'Olá, ${user.name}!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 10),
                Text('Nível ${user.level} | ${user.totalDistanceMetres / 1000} km percorridos'),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Text('Erro: $e'),
        ),
      ),
    );
  }
}
