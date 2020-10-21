import 'package:meta/meta.dart';

class DrawerNoteModel {
  DrawerNoteModel(
      {@required this.countAvailableNotes, @required this.countDeletedNotes});

  final int countAvailableNotes;
  final int countDeletedNotes;
}
