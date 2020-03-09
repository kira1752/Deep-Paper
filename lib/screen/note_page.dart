import 'package:deep_paper/provider/deep_bottom_provider.dart';
import 'package:deep_paper/provider/note_drawer_provider.dart';
import 'package:deep_paper/provider/selection_provider.dart';
import 'package:deep_paper/widget/deep_floating_action_button.dart';
import 'package:deep_paper/widget/folder_list_view.dart';
import 'package:deep_paper/widget/trash_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deep_paper/widget/note_list_view.dart';
import 'package:deep_paper/widget/deep_scrollbar.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../icons/my_icon.dart';

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrintSynchronously("Build Rebuild");
    return WillPopScope(
      onWillPop: () {
        return deselectSelectionOrExit(context);
      },
      child: Selector<SelectionProvider, bool>(
        selector: (context, provider) => provider.getSelection,
        builder: (context, selection, child) => Scaffold(
            drawerEdgeDragWidth: selection ? 0 : 20.0,
            drawer: _noteDrawer(context: context),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Selector<SelectionProvider, bool>(
                  selector: (context, provider) => provider.getSelection,
                  builder: (context, selection, child) {
                    if (selection)
                      return _normalSelectionAppBar(context: context);
                    else
                      return _defaultAppBar();
                  }),
            ),
            floatingActionButton: Selector2<NoteDrawerProvider,
                    SelectionProvider, Tuple2<int, bool>>(
                selector: (context, drawerProvider, selectionProvider) =>
                    Tuple2(drawerProvider.getIndexDrawerItem,
                        selectionProvider.getSelection),
                builder: (context, data, child) {
                  debugPrintSynchronously("Floating Action Button rebuild");

                  return Visibility(
                    visible: data.item1 != 1 && !data.item2 ? true : false,
                    child: _buildFloatingActionButton(context: context),
                  );
                }),
            body: Selector<NoteDrawerProvider, Tuple3<int, int, bool>>(
              selector: (context, drawerProvider) => Tuple3(
                  drawerProvider.getIndexDrawerItem,
                  drawerProvider.getIndexFolderItem,
                  drawerProvider.isFolder),
              builder: (context, data, child) {
                debugPrintSynchronously("Grid view rebuilt");
                if (data.item3 == true)
                  return FolderListView();
                else
                  return _showNote(index: data.item1);
              },
            )),
      ),
    );
  }

  Future<bool> deselectSelectionOrExit(BuildContext context) async {
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

  Widget _defaultAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
            icon: Icon(
              MyIcon.search,
              color: Colors.white.withOpacity(0.87),
            ),
            onPressed: () {}),
      ],
      elevation: 0.0,
      centerTitle: true,
      title: Selector<NoteDrawerProvider, String>(
        builder: (context, title, child) {
          debugPrintSynchronously("Text Title rebuilt");
          return Text('$title', style: Theme.of(context).textTheme.headline6);
        },
        selector: (context, noteDrawerProvider) =>
            noteDrawerProvider.getTitleFragment,
      ),
    );
  }

  Widget _normalSelectionAppBar({@required BuildContext context}) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<DeepBottomProvider>(context, listen: false)
                .setSelection = false;
            Provider.of<SelectionProvider>(context, listen: false)
                .setSelection = false;
            Provider.of<SelectionProvider>(context, listen: false)
                .getSelected
                .clear();
          }),
      actions: <Widget>[
        PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(child: Text("Delete")),
                  PopupMenuItem(child: Text("Move To"))
                ]),
      ],
      elevation: 0.0,
      centerTitle: true,
      title: Selector<SelectionProvider, int>(
        builder: (context, count, child) {
          debugPrintSynchronously("Text Title rebuilt");
          return Text('$count selected',
              style: Theme.of(context).textTheme.headline6);
        },
        selector: (context, provider) => provider.getSelected.length,
      ),
    );
  }

  Widget _showNote({int index}) {
    if (index == 0)
      return DeepScrollbar(child: NoteListView());
    else
      return DeepScrollbar(child: TrashListView());
  }

  Widget _noteDrawer({BuildContext context}) {
    debugPrintSynchronously("Drawer rebuilt");
    return Drawer(
        child: Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Text("NOTE", style: Theme.of(context).textTheme.headline6),
          ),
          _drawerItem(
              title: "All Notes", setIndex: 0, icon: Icons.library_books),
          _drawerItem(title: "Trash", setIndex: 1, icon: Icons.delete_outline),
          ListTile(
              title: Text("FOLDERS",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white.withOpacity(0.87))),
              trailing: FlatButton(
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.blue[400], width: 2.0)),
                  onPressed: () {},
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.87),
                    ),
                  ))),
          Expanded(child: _folderListView())
        ],
      )),
    ));
  }

  Widget _drawerItem(
      {final String title, final int setIndex, final IconData icon}) {
    return Selector<NoteDrawerProvider, bool>(
        selector: (context, drawerProvier) =>
            drawerProvier.getIndexDrawerItem == setIndex,
        builder: (context, selected, child) {
          debugPrintSynchronously("Drawer Item $title rebuilt");
          return Material(
            clipBehavior: Clip.hardEdge,
            color: selected
                ? Colors.blue[400].withOpacity(0.3)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  if (!selected &&
                      Provider.of<NoteDrawerProvider>(context, listen: false)
                              .getIndexFolderItem !=
                          null &&
                      setIndex != 0) {
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setFolderState = false;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexFolderItem = null;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexDrawerItem = setIndex;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setTitleFragment = title;
                  } else if (!selected && setIndex != 0) {
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexDrawerItem = setIndex;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setTitleFragment = title;
                  } else if (!selected &&
                      Provider.of<NoteDrawerProvider>(context, listen: false)
                              .getIndexFolderItem !=
                          null &&
                      setIndex == 0) {
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setFolderState = false;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexFolderItem = null;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexDrawerItem = setIndex;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setTitleFragment = "NOTE";
                  } else if (!selected && setIndex == 0) {
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexDrawerItem = setIndex;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setTitleFragment = "NOTE";
                  }
                },
                leading:
                    Icon(icon, color: selected ? Colors.white : Colors.white70),
                title: Text(
                  title,
                  style: selected
                      ? Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white)
                      : Theme.of(context).textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          );
        });
  }

  Widget _folderListView() {
    return DeepScrollbar(
      child: Selector<NoteDrawerProvider, int>(
          selector: (context, drawerProvider) => drawerProvider.getFolderCount,
          builder: (context, count, child) {
            debugPrintSynchronously("Folder ListView rebuilt");
            return ScrollablePositionedList.builder(
                key: const PageStorageKey("Folder ListView"),
                physics: ClampingScrollPhysics(),
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Selector<NoteDrawerProvider, bool>(
                      selector: (context, drawerProvider) =>
                          drawerProvider.getIndexFolderItem == index,
                      builder: (context, selected, child) {
                        debugPrintSynchronously("Folder $index rebuild");
                        return Material(
                          clipBehavior: Clip.hardEdge,
                          color: selected
                              ? Colors.blue[400].withOpacity(0.3)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                if (!selected &&
                                    Provider.of<NoteDrawerProvider>(context,
                                                listen: false)
                                            .getIndexDrawerItem !=
                                        null) {
                                  Provider.of<NoteDrawerProvider>(context,
                                          listen: false)
                                      .setFolderState = true;
                                  Provider.of<NoteDrawerProvider>(context,
                                          listen: false)
                                      .setIndexFolderItem = index;
                                  Provider.of<NoteDrawerProvider>(context,
                                          listen: false)
                                      .setIndexDrawerItem = null;
                                  Provider.of<NoteDrawerProvider>(context,
                                          listen: false)
                                      .setTitleFragment = "Folders $index";
                                } else if (!selected) {
                                  Provider.of<NoteDrawerProvider>(context,
                                          listen: false)
                                      .setIndexFolderItem = index;
                                  Provider.of<NoteDrawerProvider>(context,
                                          listen: false)
                                      .setTitleFragment = "Folders $index";
                                }
                              },
                              leading: Icon(Icons.folder_open,
                                  color:
                                      selected ? Colors.white : Colors.white70),
                              trailing: Icon(Icons.more_vert,
                                  color:
                                      selected ? Colors.white : Colors.white70),
                              title: Text(
                                "Folders $index",
                                style: selected
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white)
                                    : Theme.of(context).textTheme.bodyText1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        );
                      });
                });
          }),
    );
  }

  Widget _buildFloatingActionButton({BuildContext context}) {
    final icons = [
      DeepAction(
          icon: Icon(
        Icons.edit,
        color: Colors.white,
      )),
      DeepAction(
          icon: Icon(
        Icons.mic_none,
        color: Colors.white,
      )),
    ];

    return DeepFloatingActionButton(
      actions: icons,
      icon: Icon(Icons.add, color: Colors.white.withOpacity(0.87)),
      onAction: (int choice) {
        if (choice == 0) Navigator.pushNamed(context, '/NoteDetail');
      },
    );
  }
}
