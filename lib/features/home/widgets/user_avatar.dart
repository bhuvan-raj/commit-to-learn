import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class UserAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const UserAvatar({
    super.key,
    required this.initials,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: 2.5,
        ),
        color: AppColors.background,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.33,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}