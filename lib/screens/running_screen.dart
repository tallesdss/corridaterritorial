import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../widgets/territory_details_sheet.dart';
import '../services/mock_territory_service.dart';

class RunningScreen extends StatefulWidget {
  const RunningScreen({super.key});

  @override
  State<RunningScreen> createState() => _RunningScreenState();
}

class _RunningScreenState extends State<RunningScreen> {
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          // Mock Map Layer
          Container(
            color: AppColors.backgroundSecondary,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map, size: 100, color: AppColors.textMuted),
                  SizedBox(height: 16),
                  Text(
                    'Mock de Mapa em Tempo Real',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          
          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundElevated.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
            ),
          ),
          
          // Metrics Overlay (Top)
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 32,
                  ),
                ],
                border: Border.all(color: AppColors.borderSoft),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric('5.2', 'km'),
                  _buildMetric('32:14', 'Tempo'),
                  _buildMetric('5\'45"', 'Pace'),
                  _buildMetric('420', 'kcal'),
                ],
              ),
            ),
          ),
          
          // Controls Overlay (Bottom)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isPaused) ...[
                  FloatingActionButton(
                    heroTag: 'btnResume',
                    onPressed: () {
                      setState(() {
                        isPaused = false;
                      });
                    },
                    backgroundColor: AppColors.success,
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 32),
                  FloatingActionButton(
                    heroTag: 'btnFinish',
                    onPressed: () {
                      // Mock navigation to summary
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Corrida finalizada! (Mock)')),
                      );
                      context.pop();
                    },
                    backgroundColor: AppColors.error,
                    child: const Icon(Icons.stop, color: Colors.white, size: 36),
                  ),
                ] else ...[
                  FloatingActionButton(
                    heroTag: 'btnPause',
                    onPressed: () {
                      setState(() {
                        isPaused = true;
                      });
                    },
                    backgroundColor: AppColors.warning,
                    child: const Icon(Icons.pause, color: Colors.black, size: 36),
                  ),
                ]
              ],
            ),
          ),

          // Territory Discovery Overlay (Simulated)
          Positioned(
            bottom: 120,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'btnTerritory',
              onPressed: () {
                TerritoryDetailsSheet.show(
                  context, 
                  MockTerritoryService.getMockTerritory(),
                );
              },
              backgroundColor: AppColors.info,
              child: const Icon(Icons.explore, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
