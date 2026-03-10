
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../screens/main_screen.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/recover_password_screen.dart';
import '../screens/running_screen.dart';
import '../screens/run_summary_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/recover_password' ||
          state.matchedLocation == '/onboarding';

      if (authState.isLoading) return null;

      if (!isAuthenticated && !isLoggingIn) return '/onboarding';
      if (isAuthenticated && isLoggingIn) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/recover_password',
        builder: (context, state) => const RecoverPasswordScreen(),
      ),
      GoRoute(
        path: '/run',
        builder: (context, state) => const RunningScreen(),
        routes: [
           GoRoute(
            path: 'summary',
            builder: (context, state) => const RunSummaryScreen(),
          ),
        ],
      ),
    ],
  );
});
