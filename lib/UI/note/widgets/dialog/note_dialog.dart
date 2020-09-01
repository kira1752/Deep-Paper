import 'package:deep_paper/UI/note/widgets/dialog/create_folder_dialog.dart';
import 'package:deep_paper/UI/note/widgets/dialog/create_folder_move_to_dialog.dart';
import 'package:deep_paper/UI/note/widgets/dialog/delete_folder_dialog.dart';
import 'package:deep_paper/UI/note/widgets/dialog/note_info_dialog.dart';
import 'package:deep_paper/UI/note/widgets/dialog/rename_folder_dialog.dart';
import 'package:deep_paper/UI/note/widgets/dialog/restore_dialog.dart';
import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/business_logic/note/provider/text_controller_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'move_to_folder.dart';

class DeepDialog {
  DeepDialog._();

  static Future<void> openRestoreDialog(
      {@required BuildContext context, @required Note data}) {
    return showDialog(
        context: context, builder: (context) => RestoreDialog(data: data));
  }

  static Future<void> openCreateFolderDialog({
    @required BuildContext context,
  }) {
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
        child: CreateFolderDialog(),
      ),
    );
  }

  static Future<void> openCreateFolderMoveToDialog(
      {@required BuildContext context,
      @required FolderNoteData currentFolder,
      @required int drawerIndex,
      @required SelectionProvider selectionProvider,
      @required DeepBottomProvider deepBottomProvider,
      @required FABProvider fabProvider,
      DeepPaperDatabase database}) {
    return showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();

          await MoveToFolder.openMoveToDialog(
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
            ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
            ChangeNotifierProvider(
                create: (context) => DetectTextDirectionProvider())
          ],
          child: CreateFolderMoveToDialog(),
        ),
      ),
    );
  }

  static Future<void> openRenameFolderDialog({
    @required BuildContext context,
  }) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

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
        child: RenameFolderDialog(
          drawerProvider: drawerProvider,
        ),
      ),
    );
  }

  static Future<void> openDeleteFolderDialog({@required BuildContext context}) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) => DeleteFolderDialog(
              drawerProvider: drawerProvider,
            ));
  }

  static Future<void> openNoteInfo(
      {@required BuildContext context,
      @required String folderName,
      @required DateTime created,
      @required DateTime modified}) {
    return showDialog(
        context: context,
        builder: (context) => NoteInfoDialog(
              folderName: folderName,
              created: created,
              modified: modified,
            ));
  }
}
