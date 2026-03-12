import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/common/app_card.dart';
import '../widgets/common/app_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Ajuda & Suporte', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Como podemos ajudar?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildFAQSection(),
            const SizedBox(height: 32),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perguntas Frequentes',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildFAQItem(
          'Como conquistar um território?',
          'Corra em uma área que ainda não pertence a ninguém ou supere o tempo do atual dono.',
        ),
        _buildFAQItem(
          'O GPS não está marcando corretamente.',
          'Certifique-se de que o app tem permissão de "Sempre" para localização e o modo de economia de bateria está desativado.',
        ),
        _buildFAQItem(
          'Como ganho medalhas?',
          'Complete desafios diários e conquiste territórios específicos para desbloquear novas badges.',
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        iconColor: AppColors.primary,
        collapsedIconColor: AppColors.textMuted,
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        shape: const Border(), // Remove default borders
        children: [
          Text(
            answer,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return AppCard(
      backgroundColor: AppColors.backgroundSecondary,
      child: Column(
        children: [
          const Icon(Icons.headset_mic_outlined, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text(
            'Ainda precisa de ajuda?',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Nossa equipe de suporte está pronta para te atender.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Falar com Suporte',
            onPressed: () {
              // Action later
            },
          ),
        ],
      ),
    );
  }
}
