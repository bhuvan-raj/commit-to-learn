import 'package:flutter/material.dart';
import '../../../core/models/app_user.dart';

class LeaderboardTile extends StatelessWidget {
  final AppUser user;
  final int rank;

  const LeaderboardTile({
    super.key,
    required this.user,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandPurple = Color(0xFF6B21A8);
    const Color textMedium = Color(0xFF4B3F6B);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: brandPurple.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // RANK NUMBER
          SizedBox(
            width: 30,
            child: Text(
              "#$rank",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: textMedium,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // USER AVATAR
          CircleAvatar(
            radius: 20,
            backgroundColor: brandPurple.withOpacity(0.1),
            child: Text(
              user.name[0].toUpperCase(),
              style: const TextStyle(
                color: brandPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // NAME & TAG
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1A1025),
                  ),
                ),
                Text(
                  _getDevOpsRank(user.accuracyRate),
                  style: TextStyle(
                    fontSize: 12,
                    color: brandPurple.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // SCORE / ACCURACY
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${(user.accuracyRate * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: brandPurple,
                ),
              ),
              const Text(
                "Accuracy",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A fun DevOps-specific helper to assign titles based on score
  String _getDevOpsRank(double accuracy) {
    if (accuracy >= 0.9) return "Cloud Architect";
    if (accuracy >= 0.7) return "SRE Engineer";
    if (accuracy >= 0.5) return "Automation Specialist";
    return "Junior SysAdmin";
  }
}