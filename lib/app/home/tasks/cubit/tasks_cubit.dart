import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit()
      : super(
          const TasksState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const TasksState(
        documents: [],
        errorMessage: '',
        isLoading: false,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('priority')
        .snapshots()
        .listen(
      (event) {
        emit(
          TasksState(
            documents: event.docs,
            errorMessage: '',
            isLoading: false,
          ),
        );
      },
    )..onError(
        (error) {
          emit(
            TasksState(
              documents: const [],
              errorMessage: error.toString(),
              isLoading: false,
            ),
          );
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
