part of 'tasks_cubit.dart';

@immutable
class TasksState {
  const TasksState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<TaskModel> tasks;
  final bool isLoading;
  final String errorMessage;
}
