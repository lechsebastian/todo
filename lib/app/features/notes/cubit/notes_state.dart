part of 'notes_cubit.dart';

@immutable
class NotesState {
  const NotesState({
    this.notes = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<NoteModel> notes;
  final bool isLoading;
  final String errorMessage;
}
