import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:commit_to_learn/features/auth/providers/auth_providers.dart';
import 'package:commit_to_learn/features/auth/auth_repository.dart';
import 'package:commit_to_learn/features/auth/screens/login_screen.dart';
import 'package:commit_to_learn/features/auth/screens/signup_screen.dart';
import '../../features/home/screens/level_selection_screen.dart';
import '../../features/home/screens/public_profile_screen.dart';
import 'package:commit_to_learn/features/auth/screens/profile_setup_screen.dart';
import 'package:commit_to_learn/features/home/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // On Linux Firebase is not supported — skip auth, go straight to home
  if (isLinuxDesktop) {
    return GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }

  // Android / Web — full Firebase auth flow
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final user = authState.valueOrNull;
      final isLoggedIn = user != null;
      final isOnAuth = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      final isOnProfile = state.matchedLocation == '/profile-setup';

      if (!isLoggedIn) {
        return isOnAuth ? null : '/login';
      }

      if (isLoggedIn && isOnAuth) {
        final repo = ref.read(authRepositoryProvider);
        final profileComplete =
            await repo?.isProfileComplete(user.uid) ?? false;
        return profileComplete ? '/home' : '/profile-setup';
      }

      if (isLoggedIn && isOnProfile) {
        final repo = ref.read(authRepositoryProvider);
        final profileComplete =
            await repo?.isProfileComplete(user.uid) ?? false;
        return profileComplete ? '/home' : null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      // Add this under your home route
      GoRoute(
        path: '/level-selection',
        builder: (context, state) => const LevelSelectionScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile/:userId',
        builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return PublicProfileScreen(userId: userId);
  },
),
  ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
});