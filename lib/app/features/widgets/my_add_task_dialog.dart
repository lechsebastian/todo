// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/widgets/my_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAddTaskDialog extends StatefulWidget {
  const MyAddTaskDialog({super.key});

  @override
  _MyAddTaskDialogState createState() => _MyAddTaskDialogState();
}

class _MyAddTaskDialogState extends State<MyAddTaskDialog> {
  int _selectedPriority = 1;
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<RootCubit>().addTask(
                      taskName: taskController.text,
                      taskPriority: _selectedPriority,
                    );
                Navigator.of(context).pop();
                taskController.clear();
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
      title: const Text('New task'),
      content: Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              controller: taskController,
              label: 'Name',
              isObscure: false,
            ),
            const SizedBox(height: 10),
            const Text('Priority:'),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const Text('High'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const Text('Medium'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const Text('Low'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
