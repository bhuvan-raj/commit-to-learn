import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/question.dart';

class QuizRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Question>> getQuestions(String category) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', isEqualTo: category)
          .limit(10) // Fetch 10 questions per quiz session
          .get();

      return snapshot.docs.map((doc) => Question.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception("Failed to load questions: $e");
    }
  }
}