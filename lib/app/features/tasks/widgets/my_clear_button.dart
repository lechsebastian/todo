import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/tasks/cubit/tasks_cubit.dart';

class MyClearButton extends StatelessWidget {
  const MyClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.read<TasksCubit>().clearDoneTasks();
        },
        child: Text(
          'Clear',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
