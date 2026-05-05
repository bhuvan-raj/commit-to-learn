import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../leaderboard/providers/leaderboard_provider.dart';
import '../widgets/podium_item.dart';
import '../widgets/leaderboard_tile.dart';
import '../../../core/theme/app_theme.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: leaderboardAsync.when(
        data: (users) {
          if (users.isEmpty) return const Center(child: Text("No rankings yet."));

          return Column(
            children: [
              // --- PODIUM SECTION (Now Dynamic Height) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Rank 2
                    if (users.length >= 2)
                      Expanded(
                        child: _buildPodiumStage(users[1], 2, 70, const Color(0xFFC0C0C0)),
                      ),
                    
                    // Rank 1
                    if (users.length >= 1)
                      Expanded(
                        child: _buildPodiumStage(users[0], 1, 100, const Color(0xFFFFD700)),
                      ),
                    
                    // Rank 3
                    if (users.length >= 3)
                      Expanded(
                        child: _buildPodiumStage(users[2], 3, 50, const Color(0xFFCD7F32)),
                      )
                    else if (users.length < 3)
                      const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              // --- LIST SECTION ---
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      physics: const BouncingScrollPhysics(),
                      itemCount: users.length > 3 ? users.length - 3 : 0,
                      itemBuilder: (context, index) {
                        final user = users[index + 3];
                        return LeaderboardTile(user: user, rank: index + 4);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }

  Widget _buildPodiumStage(dynamic user, int rank, double height, Color medalColor) {
    const Color podiumLightPurple = Color(0xFFF5F3FF); 
    const Color podiumBorderPurple = Color(0xFFDDD6FE);

    return Column(
      mainAxisSize: MainAxisSize.min, // Take only necessary space
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PodiumItem(user: user, rank: rank),
        const SizedBox(height: 4),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: podiumLightPurple,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: podiumBorderPurple, width: 1),
          ),
          child: Center(
            child: Text(
              "#$rank",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: medalColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}