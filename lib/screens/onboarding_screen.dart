import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Hero Image (Placeholder using Icon)
              const Icon(
                Icons.directions_run_rounded,
                size: 120,
                color: AppColors.primary,
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                'Corra.\nConquiste.\nDomine.',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                'Transforme seus quilômetros em territórios e compita com sua cidade.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // CTA Button
              ElevatedButton(
                onPressed: () => context.go('/signup'),
                child: const Text('Começar a Correr'),
              ),
              const SizedBox(height: 16),
              // Login Link
              OutlinedButton(
                onPressed: () => context.go('/login'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                ),
                child: const Text('Já tenho uma conta'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
