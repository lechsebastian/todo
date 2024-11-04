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

  Future<void> switchCheckbox({required String taskID}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    final taskDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(taskID);

    final snapshot = await taskDoc.get();
    if (snapshot.exists) {
      final currentDone = snapshot.data()?['done'] as bool? ?? false;

      await taskDoc.update({'done': !currentDone});
    } else {
      throw Exception('Task does not exist');
    }
  }

  Future<void> addTask({
    required String taskName,
    required taskPriority,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .add(
      {
        'name': taskName,
        'priority': taskPriority,
        'done': false,
      },
    );
  }

  Future<void> deleteTasks() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .where('done', isEqualTo: true)
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
