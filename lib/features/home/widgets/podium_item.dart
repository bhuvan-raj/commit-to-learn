import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/app_user.dart';

class PodiumItem extends StatelessWidget {
  final AppUser user;
  final int rank;

  const PodiumItem({super.key, required this.user, required this.rank});

  @override
  Widget build(BuildContext context) {
    final bool isFirst = rank == 1;
    final Color medalColor = rank == 1 
        ? const Color(0xFFFFD700) 
        : (rank == 2 ? const Color(0xFFC0C0C0) : const Color(0xFFCD7F32));

    return GestureDetector(
      onTap: () => context.push('/profile/${user.uid}'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Crown for Rank 1
          isFirst 
            ? const Icon(Icons.workspace_premium, color: Colors.amber, size: 24)
            : const SizedBox(height: 24),
          
          CircleAvatar(
            radius: isFirst ? 32 : 26,
            backgroundColor: const Color(0xFF6B21A8).withOpacity(0.1),
            child: Text(
              user.initials,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: isFirst ? 20 : 16,
                color: const Color(0xFF6B21A8)
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 12, 
              color: Color(0xFF1E1E1E)
            ),
          ),
          Text(
            "${(user.accuracyRate * 100).toInt()}%",
            style: TextStyle(
              fontSize: 11, 
              color: medalColor, 
              fontWeight: FontWeight.w900
            ),
          ),
        ],
      ),
    );
  }
}