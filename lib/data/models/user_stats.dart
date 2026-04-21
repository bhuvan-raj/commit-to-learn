class UserStats {
  final String name;
  final String initials;
  final int totalQuizzes;
  final int questionsAnswered;
  final double accuracyRate;

  const UserStats({
    required this.name,
    required this.initials,
    required this.totalQuizzes,
    required this.questionsAnswered,
    required this.accuracyRate,
  });

  // Hardcoded mock for now — replace with Hive/SharedPrefs later
  static UserStats get mock => const UserStats(
        name: 'John',
        initials: 'JD',
        totalQuizzes: 12,
        questionsAnswered: 85,
        accuracyRate: 92.0,
      );
}