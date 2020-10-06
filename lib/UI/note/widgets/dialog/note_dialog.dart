import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/detect_text_direction_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/folder_dialog_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../business_logic/provider/text_controller_provider.dart';
import '../../../../data/deep.dart';
import 'create_folder_dialog.dart';
import 'create_folder_move_to_dialog.dart';
import 'delete_folder_dialog.dart';
import 'move_to_folder.dart' as move_to_folder;
import 'note_info_dialog.dart';
import 'rename_folder_dialog.dart';
import 'restore_dialog.dart';

Future<void> openRestoreDialog(
    {@required BuildContext context, @required Note data}) {
  return showDialog(
      context: context, builder: (context) => RestoreDialog(data: data));
}

Future<void> openCreateFolderDialog({@required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) => MultiProvider(
      providers: [
        Provider<TextControllerProvider>(
          create: (context) => TextControllerProvider(),
          dispose: (context, provider) => provider.controller.dispose(),
        ),
        ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
        ChangeNotifierProvider(
            create: (context) => DetectTextDirectionProvider())
      ],
      child: const CreateFolderDialog(),
    ),
  );
}

Future<void> openCreateFolderMoveToDialog(
    {@required BuildContext context,
    @required FolderNoteData currentFolder,
    @required int drawerIndex,
    @required SelectionProvider selectionProvider,
    @required BottomNavBarProvider deepBottomProvider,
    @required FABProvider fabProvider,
    @required DeepPaperDatabase database}) {
  return showDialog(
    context: context,
    builder: (context) =>
        WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            await move_to_folder.openMoveToDialog(
                context: context,
                currentFolder: currentFolder,
                drawerIndex: drawerIndex,
                selectionProvider: selectionProvider,
                deepBottomProvider: deepBottomProvider,
                fabProvider: fabProvider,
                database: database);

            return true;
          },
          child: MultiProvider(
            providers: [
              Provider<TextControllerProvider>(
                create: (context) => TextControllerProvider(),
                dispose: (context, provider) => provider.controller.dispose(),
              ),
              ChangeNotifierProvider(
                  create: (context) => FolderDialogProvider()),
              ChangeNotifierProvider(
                  create: (context) => DetectTextDirectionProvider())
            ],
            child: const CreateFolderMoveToDialog(),
          ),
        ),
  );
}

Future<void> openRenameFolderDialog({@required BuildContext context,
  @required NoteDrawerProvider drawerProvider}) {
  return showDialog(
    context: context,
    builder: (context) =>
        MultiProvider(
          providers: [
            Provider<TextControllerProvider>(
              create: (context) => TextControllerProvider(),
              dispose: (context, provider) => provider.controller.dispose(),
            ),
            ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
            ChangeNotifierProvider(
                create: (context) => DetectTextDirectionProvider())
          ],
          child: RenameFolderDialog(
            drawerProvider: drawerProvider,
          ),
        ),
  );
}

Future<void> openDeleteFolderDialog({@required BuildContext context,
  @required NoteDrawerProvider drawerProvider}) {
  return showDialog(
      context: context,
      builder: (context) =>
          DeleteFolderDialog(
            drawerProvider: drawerProvider,
          ));
}

Future<void> openNoteInfo({@required BuildContext context,
  @required String folderName,
  @required DateTime created,
  @required DateTime modified}) {
  return showDialog(
      context: context,
      builder: (context) =>
          NoteInfoDialog(
            folderName: folderName,
            created: created,
            modified: modified,
          ));
}
