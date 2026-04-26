import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:commit_to_learn/core/theme/app_theme.dart';
import 'package:commit_to_learn/core/router/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase does not support Linux desktop natively.
  // On Linux we skip Firebase init and run the app in local-only mode.
  if (!_isLinuxDesktop) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(
    const ProviderScope(
      child: CommitToLearnApp(),
    ),
  );
}

bool get _isLinuxDesktop =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

class CommitToLearnApp extends ConsumerWidget {
  const CommitToLearnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Commit to Learn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
