import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/app/models/note_model.dart';

class NotesRepository {
  Stream<List<NoteModel>> getNotesStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return NoteModel(
              id: doc.id,
              title: doc['title'],
              description: doc['description'],
              date: (doc['date'] as Timestamp).toDate(),
            );
          },
        ).toList();
      },
    );
  }

  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .add(
      {
        'title': title,
        'description': description,
      },
    );
  }

  Future<void> deleteNote({required String noteID}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .doc(noteID)
        .delete();
  }

  Future<void> updateNote({
    required String noteID,
    required String title,
    required String description,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .doc(noteID)
        .update({'title': title, 'description': description});
  }
}
