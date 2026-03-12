import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/app_input.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authProvider.notifier).signUp(name, email, password);
      
      if (!mounted) return;
      
      // Se chegamos aqui, o cadastro foi solicitado com sucesso.
      // Como o estado do authProvider (stream) ainda será null (esperando confirmação),
      // mostramos uma mensagem instrutiva.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada! Verifique seu e-mail para confirmar o cadastro.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );
      
      // Opcionalmente voltamos para o login
      context.pop();
    } catch (e) {
      if (!mounted) return;

      String errorMessage = 'Ocorreu um erro ao criar conta.';
      final errorStr = e.toString().toLowerCase();

      if (errorStr.contains('user already exists')) {
        errorMessage = 'Este e-mail já está cadastrado.';
      } else if (errorStr.contains('weak password')) {
        errorMessage = 'A senha é muito fraca.';
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
    _nameController.dispose();
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Junte-se a nós',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Crie sua conta e comece a correr.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              AppInput(
                controller: _nameController,
                label: 'Nome Completo',
                hint: 'Ex: Runner Zero',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              AppInput(
                controller: _emailController,
                label: 'Email',
                hint: 'seu@email.com',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              AppInput(
                controller: _passwordController,
                label: 'Senha',
                hint: 'Sua senha segura',
                isPassword: true,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Criar Conta',
                onPressed: _handleSignUp,
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
