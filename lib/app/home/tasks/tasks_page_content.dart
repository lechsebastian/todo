import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TasksPageContent extends StatelessWidget {
  const TasksPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading..'),
            );
          }

          final documents = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                for (final document in documents) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: document['done'],
                            onChanged: (value) {},
                          ),
                          Text(
                            document['name'],
                          ),
                        ],
                      ),
                      Text(
                        document['priority'].toString(),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        });
  }
}