import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/detect_text_direction_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/folder_dialog_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../business_logic/note/provider/text_controller_provider.dart';
import '../../../../data/deep.dart';
import '../../../widgets/deep_dialog_route.dart';
import 'create_folder_dialog.dart';
import 'create_folder_move_to_dialog.dart';
import 'delete_folder_dialog.dart';
import 'move_to_folder.dart';
import 'note_info_dialog.dart';
import 'rename_folder_dialog.dart';
import 'restore_dialog.dart';

// DeepDialog Utility class
class DeepDialog {
  DeepDialog._();

  static Future<void> openRestoreDialog({@required Note data}) {
    return DeepDialogRoute.dialog(RestoreDialog(data: data));
  }

  static Future<void> openCreateFolderDialog() {
    return DeepDialogRoute.dialog(
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
        child: const CreateFolderDialog(),
      ),
    );
  }

  static Future<void> openCreateFolderMoveToDialog(
      {@required FolderNoteData currentFolder,
      @required int drawerIndex,
      @required SelectionProvider selectionProvider,
      @required DeepBottomProvider deepBottomProvider,
      @required FABProvider fabProvider,
      DeepPaperDatabase database}) {
    return DeepDialogRoute.dialog(
      WillPopScope(
        onWillPop: () async {
          Get.back();
          await MoveToFolder.openMoveToDialog(
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
          child: const CreateFolderMoveToDialog(),
        ),
      ),
    );
  }

  static Future<void> openRenameFolderDialog(
      {@required NoteDrawerProvider drawerProvider}) {
    return DeepDialogRoute.dialog(
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

  static Future<void> openDeleteFolderDialog(
      {@required NoteDrawerProvider drawerProvider}) {
    return DeepDialogRoute.dialog(DeleteFolderDialog(
      drawerProvider: drawerProvider,
    ));
  }

  static Future<void> openNoteInfo(
      {@required String folderName,
      @required DateTime created,
      @required DateTime modified}) {
    return DeepDialogRoute.dialog(NoteInfoDialog(
      folderName: folderName,
      created: created,
      modified: modified,
    ));
  }
}
