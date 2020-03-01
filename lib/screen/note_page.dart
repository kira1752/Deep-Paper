import 'package:deep_paper/provider/note_drawer_provider.dart';
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
    return ChangeNotifierProvider<NoteDrawerProvider>(
      create: (_) => NoteDrawerProvider(),
      child: Scaffold(
          drawer: _noteDrawer(context: context),
          appBar: AppBar(
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
                return Text('$title',
                    style: Theme.of(context).textTheme.headline6);
              },
              selector: (context, noteDrawerProvider) =>
                  noteDrawerProvider.getTitleFragment,
            ),
          ),
          floatingActionButton: Selector<NoteDrawerProvider, int>(
              selector: (context, drawerProvider) =>
                  drawerProvider.getIndexDrawerItem,
              builder: (context, data, child) {
                debugPrintSynchronously("Floating Action Button rebuild");

                return Visibility(
                  visible: data != 1 ? true : false,
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
    return Selector<NoteDrawerProvider, int>(
        selector: (context, drawerProvier) => drawerProvier.getIndexDrawerItem,
        builder: (context, data, child) {
          debugPrintSynchronously("Drawer Item $title rebuilt");
          return Material(
            clipBehavior: Clip.hardEdge,
            color: data == setIndex
                ? Colors.blue[400].withOpacity(0.3)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  if (data != setIndex &&
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
                  } else if (data != setIndex && setIndex != 0) {
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexDrawerItem = setIndex;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setTitleFragment = title;
                  } else if (data != setIndex &&
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
                  } else if (data != setIndex && setIndex == 0) {
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setIndexDrawerItem = setIndex;
                    Provider.of<NoteDrawerProvider>(context, listen: false)
                        .setTitleFragment = "NOTE";
                  }
                },
                leading: Icon(icon,
                    color: data == setIndex ? Colors.white : Colors.white70),
                title: Text(
                  title,
                  style: data == setIndex
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
                  debugPrintSynchronously("Folder $index rebuild");
                  return Selector<NoteDrawerProvider, int>(
                    selector: (context, drawerProvider) =>
                        drawerProvider.getIndexFolderItem,
                    builder: (context, folderIndex, child) { 
                      debugPrintSynchronously("Folder $index rebuild");
                      return Material(
                      clipBehavior: Clip.hardEdge,
                      color: folderIndex == index
                          ? Colors.blue[400].withOpacity(0.3)
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (folderIndex != index &&
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
                            } else if (folderIndex != index) {
                              Provider.of<NoteDrawerProvider>(context,
                                      listen: false)
                                  .setIndexFolderItem = index;
                              Provider.of<NoteDrawerProvider>(context,
                                      listen: false)
                                  .setTitleFragment = "Folders $index";
                            }
                          },
                          leading: Icon(Icons.folder_open,
                              color: folderIndex == index
                                  ? Colors.white
                                  : Colors.white70),
                          trailing: Icon(Icons.more_vert,
                              color: folderIndex == index
                                  ? Colors.white
                                  : Colors.white70),
                          title: Text(
                            "Folders $index",
                            style: folderIndex == index
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.white)
                                : Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    );}
                  );
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
