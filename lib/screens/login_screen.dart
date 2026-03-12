import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/app_input.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authProvider.notifier).signIn(email, password);
      // Se chegou aqui sem erro, o redirect do router deve cuidar do resto
      // mas podemos forçar se necessário.
    } catch (e) {
      if (!mounted) return;
      
      String errorMessage = 'Ocorreu um erro ao entrar.';
      final errorStr = e.toString().toLowerCase();
      
      if (errorStr.contains('invalid login credentials')) {
        errorMessage = 'Email ou senha incorretos.';
      } else if (errorStr.contains('email not confirmed')) {
        errorMessage = 'Email não confirmado. Por favor, verifique sua caixa de entrada.';
      } else if (errorStr.contains('network')) {
        errorMessage = 'Erro de conexão. Verifique sua internet.';
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           content: Text(errorMessage),
           backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(onPressed: () {
          if (context.canPop()) context.pop();
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bem-vindo de\nvolta',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Entre para continuar sua conquista.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              AppInput(
                controller: _emailController,
                label: 'Email',
                hint: 'seu@email.com',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: _passwordController,
                label: 'Senha',
                hint: 'Sua senha secreta',
                isPassword: true,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/recover_password'),
                  child: const Text('Esqueceu a senha?', style: TextStyle(color: AppColors.primary)),
                ),
              ),
              const Spacer(),
              AppButton(
                label: 'Entrar',
                onPressed: _handleLogin,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
