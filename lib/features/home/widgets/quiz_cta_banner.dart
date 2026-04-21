import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class QuizCtaBanner extends StatelessWidget {
  final VoidCallback onStartPressed;

  const QuizCtaBanner({super.key, required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35), // ✅ fixed
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative background circles
          const Positioned(
            right: -20,
            top: -20,
            child: _DecorativeCircle(size: 100, opacity: 0.08),
          ),
          const Positioned(
            right: 40,
            bottom: -30,
            child: _DecorativeCircle(size: 80, opacity: 0.06),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Take a Quiz',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Ready to Test Your Skills?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              // START NOW button
              GestureDetector(
                onTap: onStartPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.15), // ✅ fixed
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.5), // ✅ fixed
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'START NOW',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2), // ✅ fixed
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const _DecorativeCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity), // ✅ fixed
      ),
    );
  }
}