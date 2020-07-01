import 'package:deep_paper/UI/note/widgets/app_bar/note_default_app_bar.dart';
import 'package:deep_paper/UI/note/widgets/build_body.dart';
import 'package:deep_paper/UI/note/widgets/drawer/deep_drawer.dart';
import 'package:deep_paper/bussiness_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
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
            child: NoteDefaultAppBar()
          ),
          floatingActionButton: Selector2<NoteDrawerProvider, SelectionProvider,
                  Tuple2<int, bool>>(
              selector: (context, drawerProvider, selectionProvider) => Tuple2(
                  drawerProvider.getIndexDrawerItem,
                  selectionProvider.getSelection),
              builder: (context, data, child) {
                return Visibility(
                    visible: data.item1 != 1 && !data.item2 ? true : false,
                    child: _buildFloatingActionButton(context: context));
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
    return FloatingActionButton(
      tooltip: "Create note",
      backgroundColor: Theme.of(context).accentColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 32.0,
      ),
      onPressed: () {
        final drawerProvider =
            Provider.of<NoteDrawerProvider>(context, listen: false);

        final FolderNoteData folder = drawerProvider.getFolder;
        Navigator.pushNamed(context, '/NoteCreate', arguments: folder);
      },
    );
  }
}
