import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/user_stats.dart';

class ProgressSnapshotCard extends StatelessWidget {
  final UserStats stats;

  const ProgressSnapshotCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.07), // ✅ fixed
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress Snapshot',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              children: [
                _StatColumn(
                  label: 'Total\nQuizzes:',
                  value: stats.totalQuizzes.toString(),
                ),
                _VerticalDivider(),
                _StatColumn(
                  label: 'Questions\nAnswered:',
                  value: stats.questionsAnswered.toString(),
                ),
                _VerticalDivider(),
                _StatColumn(
                  label: 'Accuracy\nRate:',
                  value: '${stats.accuracyRate.toInt()}%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textMedium,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.statValue,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: AppColors.divider,
    );
  }
}