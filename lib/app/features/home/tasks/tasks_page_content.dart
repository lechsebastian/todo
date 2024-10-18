import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/home/tasks/cubit/tasks_cubit.dart';
import 'package:todo/app/repositories/tasks_repository.dart';

class TasksPageContent extends StatelessWidget {
  const TasksPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(TasksRepository())..start(),
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

          final tasks = state.tasks;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                for (final task in tasks) ...[
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
                              value: task.done,
                              activeColor: Colors.black,
                              onChanged: (value) {
                                context
                                    .read<TasksCubit>()
                                    .taskDone(taskID: task.id);
                              },
                            ),
                            Text(
                              task.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: task.done
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          task.priority == 1 || task.priority == 2 ? "!" : '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: task.priority == 1 ? Colors.red : null,
                          ),
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
