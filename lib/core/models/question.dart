import 'package:cloud_firestore/cloud_firestore.dart';

enum Difficulty { easy, intermediate, expert }

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String category;
  final Difficulty difficulty;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.category,
    required this.difficulty,
  });

  // --- Firestore Serialization ---

  factory Question.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Question(
      id: doc.id,
      text: data['text'] ?? '',
      options: List<String>.from(data['options'] ?? []),
      correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
      explanation: data['explanation'] ?? '',
      category: data['category'] ?? '',
      // Convert String from Firestore back to Enum
      difficulty: Difficulty.values.firstWhere(
        (e) => e.name == (data['difficulty'] ?? 'easy'),
        orElse: () => Difficulty.easy,
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'category': category,
      // Store Enum as String in Firestore
      'difficulty': difficulty.name,
    };
  }
}