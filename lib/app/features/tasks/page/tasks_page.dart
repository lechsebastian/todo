import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo/app/features/widgets/my_add_task_dialog.dart';
import 'package:todo/app/features/widgets/my_app_bar.dart';
import 'package:todo/app/features/widgets/my_clear_button.dart';
import 'package:todo/app/features/widgets/my_done_dividers.dart';
import 'package:todo/app/features/widgets/my_drawer.dart';
import 'package:todo/app/features/widgets/my_task_view.dart';
import 'package:todo/app/repositories/tasks_repository.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
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
          final doneTasks = tasks.where((task) => task.done).toList();

          return Scaffold(
            appBar: const MyAppBar(title: 'To do'),
            drawer: const MyDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<TasksCubit>(),
                    child: const MyAddTaskDialog(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  for (final task in tasks) ...[
                    if (!task.done) MyTaskView(task: task),
                  ],
                  if (doneTasks.isNotEmpty) ...[
                    const MyDoneDividers(),
                    const MyClearButton(),
                  ],
                  for (final task in doneTasks) ...[
                    MyTaskView(task: task),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
