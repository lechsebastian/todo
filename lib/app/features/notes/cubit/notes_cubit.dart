import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/app/models/note_model.dart';
import 'package:todo/app/repositories/notes_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._notesRepository)
      : super(
          const NotesState(
            notes: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final NotesRepository _notesRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const NotesState(
        notes: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = _notesRepository.getNotesStream().listen(
      (notes) {
        emit(NotesState(notes: notes));
      },
    )..onError(
        (error) {
          emit(NotesState(errorMessage: error.toString()));
        },
      );
  }

  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    try {
      await _notesRepository.addNote(
        title: title,
        description: description,
      );
    } catch (error) {
      emit(NotesState(errorMessage: error.toString()));
    }
  }

  Future<void> deleteNote({required String noteID}) async {
    try {
      await _notesRepository.deleteNote(noteID: noteID);
    } catch (error) {
      emit(NotesState(errorMessage: error.toString()));
    }
  }

  Future<void> updateNote({
    required String noteID,
    required String title,
    required String description,
  }) async {
    try {
      await _notesRepository.updateNote(
        noteID: noteID,
        title: title,
        description: description,
      );
    } catch (error) {
      emit(NotesState(errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    return super.close();
  }
}
