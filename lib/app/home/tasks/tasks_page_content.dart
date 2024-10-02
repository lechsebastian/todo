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
                Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 24, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: document['done'],
                            activeColor: Colors.black,
                            onChanged: (value) {},
                          ),
                          Text(
                            document['name'],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Text(
                        document['priority'].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
