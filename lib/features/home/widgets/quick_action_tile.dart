import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class QuickActionTile extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const QuickActionTile({
    super.key,
    required this.label,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.06), // ✅ fixed
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}