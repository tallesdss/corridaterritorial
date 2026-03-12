import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/app_input.dart';
import '../widgets/common/app_dialog.dart';

class RecoverPasswordScreen extends ConsumerStatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  ConsumerState<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends ConsumerState<RecoverPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleRecover() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe seu email.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).resetPassword(email);
    
    if (mounted) {
       setState(() => _isLoading = false);
       AppDialog.showSuccess(
         context, 
         title: 'Recuperação Enviada', 
         message: 'Se o email informado estiver cadastrado, você receberá um link em breve.', 
         onConfirm: () {
           Navigator.pop(context); // Close dialog
           context.pop(); // Go back to login
         },
       );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Recuperar\nSenha',
                 style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Enviaremos um link para redefinir sua senha.',
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
              const SizedBox(height: 32),
              AppButton(
                label: 'Enviar Instruções',
                onPressed: _handleRecover,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
