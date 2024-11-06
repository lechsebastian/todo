import 'package:flutter/material.dart';
import 'package:todo/app/models/task_model.dart';

class MyPrioritySymbol extends StatelessWidget {
  const MyPrioritySymbol({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    if (task.done) {
      return task.priority == 1 || task.priority == 2
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.priority == 1
                    ? Colors.red.shade200
                    : Colors.grey.shade400,
              ),
            )
          : const SizedBox(width: 10, height: 10);
    }

    return task.priority == 1 || task.priority == 2
        ? Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: task.priority == 1 ? Colors.red : Colors.black,
            ),
          )
        : const SizedBox(width: 10, height: 10);
  }
}
