import 'package:meta/meta.dart';

import '../../data/deep.dart';

class DrawerFolderModel {
  DrawerFolderModel({@required this.folder, @required this.count});

  final FolderNoteData folder;
  final int count;
}