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
}