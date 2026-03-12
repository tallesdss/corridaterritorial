import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/achievement_provider.dart';
import '../theme/app_colors.dart';
import '../models/achievement_model.dart';
import '../widgets/common/app_card.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(achievementsFutureProvider);
    
    return achievementsAsync.when(
      data: (achievements) {
        final unlockedCount = achievements.where((a) => a.isUnlocked).length;

        return Scaffold(
          backgroundColor: AppColors.backgroundPrimary,
          appBar: AppBar(
            title: const Text(
              'Conquistas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppColors.backgroundPrimary,
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryCard(unlockedCount, achievements.length),
                      const SizedBox(height: 32),
                      Text(
                        'Minha Galeria',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildAchievementCard(context, achievements[index]);
                    },
                    childCount: achievements.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: Center(child: Text('Erro ao carregar conquistas: $err', style: const TextStyle(color: AppColors.error))),
      ),
    );
  }

  Widget _buildSummaryCard(int unlocked, int total) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progresso Total',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$unlocked de $total conquistados',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: unlocked / total,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(BuildContext context, AchievementModel achievement) {
    return AppCard(
      onTap: () => _showAchievementDetail(context, achievement),
      padding: EdgeInsets.zero,
      borderSide: BorderSide(
        color: achievement.isUnlocked 
          ? achievement.color.withValues(alpha: 0.5) 
          : AppColors.borderDefault,
        width: 1.5,
      ),
      boxShadow: achievement.isUnlocked ? [
        BoxShadow(
          color: achievement.color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        )
      ] : null,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: achievement.isUnlocked 
                      ? achievement.color.withValues(alpha: 0.1) 
                      : AppColors.backgroundElevated,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    achievement.icon,
                    color: achievement.isUnlocked 
                      ? achievement.color 
                      : AppColors.textMuted,
                    size: 36,
                  ),
                ),
                if (!achievement.isUnlocked)
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.backgroundElevated,
                      child: Icon(Icons.lock, size: 14, color: AppColors.textMuted),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                achievement.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: achievement.isUnlocked ? AppColors.textPrimary : AppColors.textMuted,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (!achievement.isUnlocked)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: achievement.progress,
                    backgroundColor: AppColors.backgroundElevated,
                    valueColor: AlwaysStoppedAnimation<Color>(achievement.color.withValues(alpha: 0.5)),
                    minHeight: 4,
                  ),
                ),
            ),
          ],
        ),
    );
  }

  void _showAchievementDetail(BuildContext context, AchievementModel achievement) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundElevated,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: achievement.isUnlocked 
                  ? achievement.color.withValues(alpha: 0.1) 
                  : AppColors.backgroundPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                achievement.icon,
                color: achievement.isUnlocked ? achievement.color : AppColors.textMuted,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              achievement.title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              achievement.category.name.toUpperCase(),
              style: TextStyle(
                color: achievement.color,
                fontSize: 12,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              achievement.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            if (achievement.isUnlocked)
              Text(
                'Conquistado em ${achievement.unlockedAt?.day}/${achievement.unlockedAt?.month}/${achievement.unlockedAt?.year}',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                ),
              )
            else
              Column(
                children: [
                  Text(
                    'Progresso: ${(achievement.progress * 100).toInt()}%',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: achievement.progress,
                      minHeight: 12,
                      backgroundColor: AppColors.backgroundPrimary,
                      valueColor: AlwaysStoppedAnimation<Color>(achievement.color),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
