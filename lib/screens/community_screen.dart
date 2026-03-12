import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ranked_user_model.dart';
import '../services/ranking_service.dart';
import '../theme/app_colors.dart';

enum RankingFilter { territory, distance, achievements }

class RankingFilterNotifier extends Notifier<RankingFilter> {
  @override
  RankingFilter build() => RankingFilter.territory;

  void setFilter(RankingFilter filter) => state = filter;
}

final rankingFilterProvider = NotifierProvider<RankingFilterNotifier, RankingFilter>(RankingFilterNotifier.new);

final rankingFutureProvider = FutureProvider<List<RankedUserModel>>((ref) async {
  final filter = ref.watch(rankingFilterProvider);
  final service = ref.watch(rankingServiceProvider);
  
  // Observa mudanças nas tabelas usando a extensão criada no serviço
  final sub = service.watchProfiles().listen((_) {
    // Invalida o provider toda vez que ocorrer uma mudança
    ref.invalidateSelf();
  });
  
  ref.onDispose(() {
    sub.cancel();
  });

  switch (filter) {
    case RankingFilter.territory:
      return service.getRankingByTerritory();
    case RankingFilter.distance:
      return service.getRankingByDistance();
    case RankingFilter.achievements:
      return service.getRankingByAchievements();
  }
});

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(rankingFilterProvider);
    final rankingAsync = ref.watch(rankingFutureProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text('Community', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary)),
        backgroundColor: AppColors.backgroundSecondary,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilterChips(context, ref, filter),
          Expanded(
            child: rankingAsync.when(
              data: (users) {
                if (users.isEmpty) {
                  return const Center(child: Text('Nenhum dado encontrado', style: TextStyle(color: Colors.white)));
                }
                return RefreshIndicator(
                  onRefresh: () async => ref.refresh(rankingFutureProvider),
                  color: AppColors.primary,
                  backgroundColor: AppColors.backgroundSecondary,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (users.length >= 3) _buildTop3(context, users.take(3).toList()),
                      const SizedBox(height: 24),
                      Text('Ranking Global', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: 16),
                      ...users.map((user) => _buildRankingItem(context, user, users.indexOf(user) + 1, filter)),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              error: (err, stack) => Center(child: Text('Erro ao carregar ranking', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.error))),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, WidgetRef ref, RankingFilter currentFilter) {
    return Container(
      color: AppColors.backgroundSecondary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChip(
              context,
              label: 'Territórios', 
              icon: Icons.map,
              isSelected: currentFilter == RankingFilter.territory,
              onTap: () => ref.read(rankingFilterProvider.notifier).setFilter(RankingFilter.territory),
            ),
            const SizedBox(width: 8),
            _buildChip(
              context,
              label: 'Distância', 
              icon: Icons.directions_run,
              isSelected: currentFilter == RankingFilter.distance,
              onTap: () => ref.read(rankingFilterProvider.notifier).setFilter(RankingFilter.distance),
            ),
            const SizedBox(width: 8),
            _buildChip(
              context,
              label: 'Conquistas', 
              icon: Icons.emoji_events,
              isSelected: currentFilter == RankingFilter.achievements,
              onTap: () => ref.read(rankingFilterProvider.notifier).setFilter(RankingFilter.achievements),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, {required String label, required IconData icon, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : AppColors.backgroundCard,
          border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTop3(BuildContext context, List<RankedUserModel> top3) {
    if (top3.length < 3) {
      return const SizedBox();
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPodiumItem(context, top3[1], 2, 80),
        _buildPodiumItem(context, top3[0], 1, 100),
        _buildPodiumItem(context, top3[2], 3, 70),
      ],
    );
  }

  Widget _buildPodiumItem(BuildContext context, RankedUserModel user, int position, double size) {
    Color ringColor;
    if (position == 1) {
      ringColor = Colors.amber;
    } else if (position == 2) {
      ringColor = Colors.grey[300]!;
    } else {
      ringColor = Colors.orange[300]!;
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ringColor, width: 3),
              ),
              child: CircleAvatar(
                radius: size / 2,
                backgroundColor: AppColors.backgroundCard,
                backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                child: user.avatarUrl == null ? const Icon(Icons.person, color: AppColors.textSecondary, size: 40) : null,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ringColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$positionº',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          user.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildRankingItem(BuildContext context, RankedUserModel user, int position, RankingFilter filter) {
    String scoreText;
    switch (filter) {
      case RankingFilter.territory:
        scoreText = '${user.territoryScore} pts';
        break;
      case RankingFilter.distance:
        scoreText = '${user.distanceKm.toStringAsFixed(1)} km';
        break;
      case RankingFilter.achievements:
        scoreText = '${user.achievements} conquistas';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: user.name == 'Eu (Você)' ? Border.all(color: AppColors.primary, width: 1.5) : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$positionº',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: position <= 3 ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.backgroundSecondary,
            backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
            child: user.avatarUrl == null ? const Icon(Icons.person, color: AppColors.textSecondary, size: 20) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              user.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: user.name == 'Eu (Você)' ? AppColors.primary : AppColors.textPrimary,
                fontWeight: user.name == 'Eu (Você)' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            scoreText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.info,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
