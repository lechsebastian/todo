import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/models/task_model.dart';

class TasksRepository {
  Stream<List<TaskModel>> getTasksStream() {
    return FirebaseFirestore.instance
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
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskID)
        .update({'done': true});
    await FirebaseFirestore.instance.collection('tasks').doc(taskID).delete();
  }
}
