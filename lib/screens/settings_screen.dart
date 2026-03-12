import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../widgets/common/app_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _useMetricSystem = true;
  bool _privacyMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Configurações', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionTitle('Preferências'),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSwitchTile(
                  title: 'Notificações',
                  subtitle: 'Receber alertas de conquistas e territórios',
                  value: _notificationsEnabled,
                  onChanged: (val) => setState(() => _notificationsEnabled = val),
                  icon: Icons.notifications_outlined,
                ),
                const Divider(height: 1, color: AppColors.borderDefault, indent: 56),
                _buildSwitchTile(
                  title: 'Sistema Métrico',
                  subtitle: 'Usar quilômetros (km) em vez de milhas',
                  value: _useMetricSystem,
                  onChanged: (val) => setState(() => _useMetricSystem = val),
                  icon: Icons.straighten_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Privacidade'),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSwitchTile(
                  title: 'Perfil Público',
                  subtitle: 'Outros corredores podem ver seus territórios',
                  value: !_privacyMode,
                  onChanged: (val) => setState(() => _privacyMode = !val),
                  icon: Icons.visibility_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Conta'),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSimpleTile(
                  title: 'Alterar Senha',
                  icon: Icons.lock_outline,
                  onTap: () {
                    // Implement flow later
                  },
                ),
                const Divider(height: 1, color: AppColors.borderDefault, indent: 56),
                _buildSimpleTile(
                  title: 'Excluir Conta',
                  icon: Icons.delete_outline,
                  color: AppColors.error,
                  onTap: () {
                    // Show confirmation dialog
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Versão 1.0.0 (Beta)',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      activeTrackColor: AppColors.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildSimpleTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimary),
      title: Text(title, style: TextStyle(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
