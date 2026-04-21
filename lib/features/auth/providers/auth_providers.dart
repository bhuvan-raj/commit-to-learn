import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commit_to_learn/core/models/app_user.dart';
import 'package:commit_to_learn/features/auth/auth_repository.dart';

bool get isLinuxDesktop =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

// ── Repository provider ──────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository?>((ref) {
  if (isLinuxDesktop) return null;
  return AuthRepository();
});

// ── Firebase auth state stream ───────────────────────────────────────────────

final authStateProvider = StreamProvider<User?>((ref) {
  if (isLinuxDesktop) return const Stream.empty();
  final repo = ref.watch(authRepositoryProvider);
  if (repo == null) return const Stream.empty();
  return repo.authStateChanges;
});

// ── Current AppUser from Firestore ───────────────────────────────────────────

final appUserProvider = FutureProvider<AppUser?>((ref) async {
  if (isLinuxDesktop) return null;
  final repo = ref.read(authRepositoryProvider);
  if (repo == null) return null;
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) async {
      if (user == null) return null;
      return repo.getUser(user.uid);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

// ── Auth notifier ────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository? _repo;

  AuthNotifier(this._repo) : super(const AsyncValue.data(null));

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final repo = _repo;
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repo.signUpWithEmail(email: email, password: password),
    );
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final repo = _repo;
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repo.signInWithEmail(email: email, password: password),
    );
  }

  Future<void> signInWithGoogle() async {
    final repo = _repo;
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.signInWithGoogle());
  }

  Future<void> sendPasswordReset(String email) async {
    final repo = _repo;
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repo.sendPasswordResetEmail(email),
    );
  }

  Future<void> signOut() async {
    final repo = _repo;
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.signOut());
  }

  void resetState() {
    state = const AsyncValue.data(null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});