import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final int totalQuizzes;
  final int questionsAnswered;
  final double accuracyRate;
  final int currentStreak;
  final int bestStreak;
  final int leaderboardRank;
  final List<QuizHistory> quizHistory;
  final DateTime createdAt;
  final DateTime lastSeen;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.totalQuizzes = 0,
    this.questionsAnswered = 0,
    this.accuracyRate = 0.0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.leaderboardRank = 0,
    this.quizHistory = const [],
    required this.createdAt,
    required this.lastSeen,
  });

  /// Initials derived from name (e.g. "John Doe" → "JD")
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  // ── Firestore serialisation ──────────────────────────────────────────────

  /// Use this when you have a direct DocumentSnapshot from Firebase
  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser.fromMap(data, doc.id);
  }

  /// NEW: Use this when you have a Map (e.g. in Leaderboards or Lists)
  factory AppUser.fromMap(Map<String, dynamic> data, [String? id]) {
    return AppUser(
      uid: id ?? data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      totalQuizzes: data['totalQuizzes'] ?? 0,
      questionsAnswered: data['questionsAnswered'] ?? 0,
      accuracyRate: (data['accuracyRate'] ?? 0.0).toDouble(),
      currentStreak: data['currentStreak'] ?? 0,
      bestStreak: data['bestStreak'] ?? 0,
      leaderboardRank: data['leaderboardRank'] ?? 0,
      quizHistory: (data['quizHistory'] as List<dynamic>? ?? [])
          .map((e) => QuizHistory.fromMap(e as Map<String, dynamic>))
          .toList(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastSeen: (data['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'totalQuizzes': totalQuizzes,
      'questionsAnswered': questionsAnswered,
      'accuracyRate': accuracyRate,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      'leaderboardRank': leaderboardRank,
      'quizHistory': quizHistory.map((e) => e.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
      'lastSeen': Timestamp.fromDate(lastSeen),
    };
  }

  AppUser copyWith({
    String? name,
    String? email,
    String? photoUrl,
    int? totalQuizzes,
    int? questionsAnswered,
    double? accuracyRate,
    int? currentStreak,
    int? bestStreak,
    int? leaderboardRank,
    List<QuizHistory>? quizHistory,
    DateTime? lastSeen,
  }) {
    return AppUser(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      accuracyRate: accuracyRate ?? this.accuracyRate,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      leaderboardRank: leaderboardRank ?? this.leaderboardRank,
      quizHistory: quizHistory ?? this.quizHistory,
      createdAt: createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}

// ── Quiz history entry ───────────────────────────────────────────────────────

class QuizHistory {
  final String quizId;
  final String category;
  final int score;
  final int totalQuestions;
  final double accuracy;
  final DateTime completedAt;

  const QuizHistory({
    required this.quizId,
    required this.category,
    required this.score,
    required this.totalQuestions,
    required this.accuracy,
    required this.completedAt,
  });

  factory QuizHistory.fromMap(Map<String, dynamic> map) {
    return QuizHistory(
      quizId: map['quizId'] ?? '',
      category: map['category'] ?? '',
      score: map['score'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      accuracy: (map['accuracy'] ?? 0.0).toDouble(),
      completedAt:
          (map['completedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'category': category,
      'score': score,
      'totalQuestions': totalQuestions,
      'accuracy': accuracy,
      'completedAt': Timestamp.fromDate(completedAt),
    };
  }
}