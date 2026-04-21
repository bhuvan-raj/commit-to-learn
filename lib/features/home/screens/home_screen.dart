import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:commit_to_learn/core/theme/app_theme.dart';
import 'package:commit_to_learn/data/models/user_stats.dart';
import '../widgets/user_avatar.dart';
import '../widgets/progress_snapshot_card.dart';
import '../widgets/quiz_cta_banner.dart';
import '../widgets/quick_action_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  final UserStats _stats = UserStats.mock;

  void _onNavTapped(int index) {
    setState(() => _currentNavIndex = index);
    // TODO: hook into go_router navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              ProgressSnapshotCard(stats: _stats),
              const SizedBox(height: 20),
              QuizCtaBanner(
                onStartPressed: () {
                  // TODO: navigate to quiz selection screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Starting quiz...')),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: QuickActionTile(
                      label: 'Tool\nSpecific',
                      onTap: () {
                        // TODO: navigate to tool-specific quiz screen
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: QuickActionTile(
                      label: 'FAQs',
                      onTap: () {
                        // TODO: navigate to FAQ screen
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
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
                text: '${_stats.name}!',
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
        UserAvatar(initials: _stats.initials),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
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