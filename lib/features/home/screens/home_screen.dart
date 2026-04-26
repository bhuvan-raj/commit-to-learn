import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // REQUIRED for navigation
import 'package:commit_to_learn/core/theme/app_theme.dart';
import 'package:commit_to_learn/data/models/user_stats.dart';
import 'package:commit_to_learn/features/auth/providers/auth_providers.dart';
import 'package:commit_to_learn/features/home/widgets/user_avatar.dart';
import 'package:commit_to_learn/features/home/widgets/progress_snapshot_card.dart';
import 'package:commit_to_learn/features/home/widgets/quiz_cta_banner.dart';
import 'package:commit_to_learn/features/home/widgets/quick_action_tile.dart';

// NEW IMPORT
import 'leaderboard_screen.dart'; 

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentNavIndex = 0;

  void _onNavTapped(int index) {
    setState(() => _currentNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // Pull real user from Firebase
    final appUserAsync = ref.watch(appUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _currentNavIndex == 1
            ? const LeaderboardScreen() // Show Leaderboard if index is 1
            : appUserAsync.when(
                data: (appUser) {
                  final stats = appUser != null
                      ? UserStats(
                          name: appUser.name,
                          initials: appUser.initials,
                          totalQuizzes: appUser.totalQuizzes,
                          questionsAnswered: appUser.questionsAnswered,
                          accuracyRate: appUser.accuracyRate,
                        )
                      : UserStats.mock;

                  return _buildDashboardView(stats); // Show Dashboard if index is 0
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (e, stack) => _buildErrorView(e),
              ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- Dashboard Content ---
  Widget _buildDashboardView(UserStats stats) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(stats),
          const SizedBox(height: 24),
          ProgressSnapshotCard(stats: stats),
          const SizedBox(height: 20),
          QuizCtaBanner(
            onStartPressed: () {
              // UPDATED: Now navigates to Level Selection
              context.push('/level-selection'); 
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: QuickActionTile(
                  label: 'Tool\nSpecific',
                  onTap: () {
                    // Placeholder for future tool-specific route
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: QuickActionTile(
                  label: 'FAQs',
                  onTap: () {
                    // Placeholder for FAQ route
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(UserStats stats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome,\n',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    height: 1.1,
                  ),
                ),
                TextSpan(
                  text: '${stats.name}!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        UserAvatar(initials: stats.initials),
      ],
    );
  }

  Widget _buildErrorView(Object e) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error loading user data',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              e.toString(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: AppColors.textMedium,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.navActive,
        unselectedItemColor: AppColors.navInactive,
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Leaderboards',
          ),
        ],
      ),
    );
  }
}