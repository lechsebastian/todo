import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo/app/features/widgets/my_priority_symbol.dart';
import 'package:todo/app/models/task_model.dart';

class MyTaskView extends StatelessWidget {
  const MyTaskView({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 24, top: 2, bottom: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: task.done ? Colors.grey.shade200 : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Checkbox(
                    value: task.done,
                    activeColor: task.done ? Colors.black26 : Colors.black,
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
                        color: task.done ? Colors.black26 : Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration:
                            task.done ? TextDecoration.lineThrough : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            MyPrioritySymbol(task: task),
          ],
        ),
      ),
    );
  }
}
