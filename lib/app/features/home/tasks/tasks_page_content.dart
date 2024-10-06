import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/home/tasks/cubit/tasks_cubit.dart';

class TasksPageContent extends StatelessWidget {
  const TasksPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..start(),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Something went wrong. Error: ${state.errorMessage}'),
            );
          }

          if (state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 5),
                  Text('Loading..'),
                ],
              ),
            );
          }

          final documents = state.documents;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                for (final document in documents) ...[
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 24, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
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
                              onChanged: (value) {
                                context
                                    .read<TasksCubit>()
                                    .taskDone(documentID: document.id);
                              },
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
                  const SizedBox(height: 12),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
