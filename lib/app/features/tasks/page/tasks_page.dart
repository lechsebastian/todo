import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/settings/page/settings_page.dart';
import 'package:todo/app/features/tasks/cubit/tasks_cubit.dart';
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
            appBar: AppBar(
              title: const Text(
                'TO DO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.grey.shade300,
            ),
            drawer: Drawer(
              child: Container(
                color: Colors.grey.shade300,
                child: ListView(
                  children: [
                    const DrawerHeader(
                      child: Icon(
                        Icons.assignment,
                        size: 100,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: const Icon(Icons.assignment_turned_in),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const TasksPage()));
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: const Icon(Icons.sticky_note_2),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: const Icon(Icons.settings),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.grey.shade300,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  for (final task in tasks) ...[
                    if (!task.done)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 24, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: task.done,
                                      activeColor: Colors.black,
                                      onChanged: (value) {
                                        context
                                            .read<TasksCubit>()
                                            .switchCheckbox(taskID: task.id);
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        task.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          decoration: task.done
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                task.priority == 1 || task.priority == 2
                                    ? " !"
                                    : ' ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: task.priority == 1 ? Colors.red : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                  if (doneTasks.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'done',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.read<TasksCubit>().clearDoneTasks();
                        },
                        child: const Text(
                          'Clear',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                  for (final task in doneTasks) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 24, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: task.done,
                                    activeColor: Colors.black26,
                                    onChanged: (value) {
                                      context
                                          .read<TasksCubit>()
                                          .switchCheckbox(taskID: task.id);
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      task.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black26,
                                        decoration: task.done
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              task.priority == 1 || task.priority == 2
                                  ? " !"
                                  : ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: task.priority == 1
                                    ? Colors.red.shade200
                                    : Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
