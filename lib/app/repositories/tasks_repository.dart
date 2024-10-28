import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/app/models/task_model.dart';

class TasksRepository {
  Stream<List<TaskModel>> getTasksStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .orderBy('priority')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return TaskModel(
                id: doc.id,
                name: doc['name'],
                priority: doc['priority'],
                done: doc['done']);
          },
        ).toList();
      },
    );
  }

  Future<void> deleteTask({required String taskID}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(taskID)
        .update({'done': true});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(taskID)
        .delete();
  }
}
