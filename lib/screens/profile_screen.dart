import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/run_provider.dart';
import '../theme/app_colors.dart';
import '../models/user_model.dart';
import '../widgets/common/app_card.dart';
import '../widgets/common/app_input.dart';
import '../widgets/common/app_dialog.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);
    final runsState = ref.watch(runsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: userState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Nenhum usuário logado'));
          }
          return CustomScrollView(
            slivers: [
              _buildAppBar(context, user),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildStats(context, user, runsState),
                      const SizedBox(height: 32),
                      _buildMenu(context, ref),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, UserModel user) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.backgroundPrimary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.backgroundPrimary,
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.backgroundSecondary,
                    backgroundImage: user.profilePicture != null
                        ? NetworkImage(user.profilePicture!)
                        : null,
                    child: user.profilePicture == null
                        ? const Icon(Icons.person, size: 60, color: AppColors.textSecondary)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context, UserModel user, AsyncValue runsState) {
    return runsState.when(
      data: (runs) {
        final totalRuns = runs.length;
        final totalDistance = runs.fold(0.0, (sum, run) => sum + run.distanceKm);
        // Mocking territories for now as requested by Section 11 docs
        const totalTerritories = 12;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(context, 'Atividades', totalRuns.toString(), Icons.directions_run),
            _buildStatCard(context, 'Km Totais', totalDistance.toStringAsFixed(1), Icons.map),
            _buildStatCard(context, 'Territórios', totalTerritories.toString(), Icons.flag),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (err, stack) => const Text('Erro ao carregar stats'),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: AppCard(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.edit,
          title: 'Editar Perfil',
          onTap: () => _showEditProfileDialog(context, ref),
        ),
        _buildMenuItem(
          icon: Icons.settings,
          title: 'Configurações',
          onTap: () => context.push('/settings'),
        ),
        _buildMenuItem(
          icon: Icons.help_outline,
          title: 'Ajuda & Suporte',
          onTap: () => context.push('/help'),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Sair',
          color: AppColors.error,
          onTap: () async {
            await ref.read(authProvider.notifier).logOut();
            // Assuming the router/MainScreen handles redirection to login when auth state is null
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.textPrimary),
        title: Text(
          title,
          style: TextStyle(
            color: color ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: ref.read(authProvider).value?.name);

    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Editar Perfil',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInput(
              label: 'Nome',
              hint: 'Seu nome de exibição',
              controller: nameController,
              icon: Icons.person_outline,
            ),
          ],
        ),
        confirmLabel: 'Salvar',
        onConfirm: () {
          ref.read(authProvider.notifier).updateProfile(name: nameController.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
