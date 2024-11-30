import 'package:intl/intl.dart';

class NoteModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  String releaseDateFormatted() {
    return DateFormat.yMMMd().format(date);
  }
}
