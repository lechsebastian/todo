import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit()
      : super(
          const RootState(
            user: null,
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const RootState(
        user: null,
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        emit(
          RootState(
            user: user,
            errorMessage: '',
            isLoading: false,
          ),
        );
      },
    )..onError(
        (error) {
          emit(
            RootState(
              user: null,
              errorMessage: error.toString(),
              isLoading: false,
            ),
          );
        },
      );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print('Error has been occured: $error');
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print('Error has been occured: $error');
    }
  }

  Future<void> addTask({
    required String taskName,
    required taskPriority,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not signed in');
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .add(
      {
        'name': taskName,
        'priority': taskPriority,
        'done': false,
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
