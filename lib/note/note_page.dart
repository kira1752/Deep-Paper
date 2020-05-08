import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/widgets/app_bar/normal_selection_app_bar.dart';
import 'package:deep_paper/note/widgets/app_bar/trash_selection_app_bar.dart';
import 'package:deep_paper/note/widgets/build_body.dart';
import 'package:deep_paper/note/widgets/app_bar/default_app_bar.dart';
import 'package:deep_paper/note/widgets/drawer/deep_drawer.dart';
import 'package:deep_paper/note/widgets/deep_floating_action_button.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitSelectionOrExitApp(context);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: DeepDrawer(key: Key("Note Drawer")),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
            child: Selector<SelectionProvider, bool>(
                selector: (context, provider) => provider.getSelection,
                builder: (context, selection, child) {
                  if (selection) {
                    final drawerProvider =
                        Provider.of<NoteDrawerProvider>(context, listen: false);

                    final selectionAppBar =
                        drawerProvider.getIndexDrawerItem == 1
                            ? TrashSelectionAppBar()
                            : NormalSelectionAppBar();

                    return selectionAppBar;
                  } else
                    return DefaultAppBar();
                }),
          ),
          floatingActionButton: Selector2<NoteDrawerProvider, SelectionProvider,
                  Tuple2<int, bool>>(
              selector: (context, drawerProvider, selectionProvider) => Tuple2(
                  drawerProvider.getIndexDrawerItem,
                  selectionProvider.getSelection),
              builder: (context, data, child) {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 150),
                  opacity: data.item1 != 1 && !data.item2 ? 1 : 0,
                  child: _buildFloatingActionButton(context: context),
                );
              }),
          body: BuildBody()),
    );
  }

  Future<bool> exitSelectionOrExitApp(BuildContext context) async {
    final providerSelection =
        Provider.of<SelectionProvider>(context, listen: false);
    final providerDeepBottom =
        Provider.of<DeepBottomProvider>(context, listen: false);
    final selection = providerSelection.getSelection;

    if (selection) {
      providerSelection.setSelection = false;
      providerDeepBottom.setSelection = false;
      providerSelection.getSelected.clear();
      return false;
    } else
      return true;
  }

  Widget _buildFloatingActionButton({BuildContext context}) {
    final icons = [
      DeepAction(
          tooltip: "Write note",
          icon: Icon(
            Icons.edit,
            size: 24.0,
            color: Colors.white,
          )),
      DeepAction(
          tooltip: "Audio note",
          icon: Icon(
            Icons.mic_none,
            size: 24.0,
            color: Colors.white,
          )),
    ];

    return DeepFloatingActionButton(
      actions: icons,
      tooltip: "Open create note menu",
      icon: Icon(
        Icons.add,
        color: Colors.white,
        size: 32.0,
      ),
      onAction: (int choice) {
        if (choice == 0) {
          final drawerProvider =
              Provider.of<NoteDrawerProvider>(context, listen: false);

          final FolderNoteData folder = drawerProvider.getFolder;
          Navigator.pushNamed(context, '/NoteDetail', arguments: folder);
        }
      },
    );
  }
}
