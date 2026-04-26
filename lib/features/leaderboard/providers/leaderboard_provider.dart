import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/app_user.dart';

final leaderboardProvider = FutureProvider<List<AppUser>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  
  final snapshot = await firestore
      .collection('users')
      .orderBy('accuracyRate', descending: true)
      .limit(20)
      .get();

  return snapshot.docs.map((doc) => AppUser.fromMap(doc.data())).toList();
});