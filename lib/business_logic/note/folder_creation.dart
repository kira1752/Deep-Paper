import 'package:moor/moor.dart';

import '../../data/deep.dart';
import '../../resource/string_resource.dart';
import '../detect_text_direction_to_string.dart';
import 'provider/note_drawer_provider.dart';

void create({@required DeepPaperDatabase database, @required String name}) {
  final nameDirection = detectTextDirection(name);

  database.folderNoteDao.insertFolder(FolderNoteCompanion(
      name: Value(name), nameDirection: Value(nameDirection)));
}

void update(
    {@required DeepPaperDatabase database,
    @required NoteDrawerProvider drawerProvider,
    @required String name}) {
  final nameDirection = detectTextDirection(name);

  database.folderNoteDao.updateFolder(drawerProvider.getFolder
      .copyWith(name: name, nameDirection: nameDirection));

  drawerProvider.setTitleFragment = '$name';
  drawerProvider.setFolder = drawerProvider.getFolder
      .copyWith(name: name, nameDirection: nameDirection);

  database.noteDao.renameFolderAssociation(drawerProvider.getFolder);
}

Future<void> delete({
  @required DeepPaperDatabase database,
  @required NoteDrawerProvider drawerProvider,
}) async {
  await database.noteDao.moveNoteToTrash(drawerProvider.getFolder);

  await database.folderNoteDao.deleteFolder(drawerProvider.getFolder);

  drawerProvider.setFolderState = false;
  drawerProvider.setIndexFolderItem = null;
  drawerProvider.setFolder = null;
  drawerProvider.setIndexDrawerItem = 0;
  drawerProvider.setTitleFragment = StringResource.all_notes;
}
