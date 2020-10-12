import 'package:meta/meta.dart';

class UndoModel {
  final bool canUndo;
  final bool canRedo;

  UndoModel({@required this.canUndo, @required this.canRedo});
}
