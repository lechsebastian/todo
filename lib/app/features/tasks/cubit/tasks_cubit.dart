import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/repositories/tasks_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._tasksRepository)
      : super(
          const TasksState(
            tasks: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final TasksRepository _tasksRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const TasksState(
        tasks: [],
        errorMessage: '',
        isLoading: false,
      ),
    );

    _streamSubscription = _tasksRepository.getTasksStream().listen(
      (tasks) {
        emit(TasksState(tasks: tasks));
      },
    )..onError(
        (error) {
          emit(TasksState(errorMessage: error.toString()));
        },
      );
  }

  Future<void> switchCheckbox({required String taskID}) async {
    try {
      await _tasksRepository.switchCheckbox(taskID: taskID);
    } catch (error) {
      emit(TasksState(errorMessage: error.toString()));
    }
  }

  Future<void> clearDoneTasks() async {
    try {
      await _tasksRepository.deleteTasks();
    } catch (error) {
      emit(TasksState(errorMessage: error.toString()));
    }
  }

  Future<void> addTask({
    required String taskName,
    required taskPriority,
  }) async {
    try {
      await _tasksRepository.addTask(
        taskName: taskName,
        taskPriority: taskPriority,);
    } catch (error) {
      emit(TasksState(errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
