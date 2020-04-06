import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TrashMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllDeletedNotes(),
      child: Selector2<NoteDrawerProvider, List<Note>, bool>(
        selector: (context, provider, data) =>
            provider.getIndexDrawerItem == 1 && data != null && data.isNotEmpty,
        builder: (context, showMenu, child) {
          debugPrintSynchronously("Trash Menu rebuild");
          return Visibility(
            visible: showMenu,
            child: PopupMenuButton(
                tooltip: "Open Trash Bin menu",
                onSelected: (choice) {
                  if (choice == 0) _onEmptyTrashBin(context: context);
                },
                padding: EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 0,
                        child: ListTile(
                          leading: Icon(
                            MyIcon.trash_empty,
                            color: Colors.white60,
                          ),
                          title: Text(
                            "Empty Trash Bin",
                          ),
                        ))
                  ];
                }),
          );
        },
      ),
    );
  }

  Future<void> _onEmptyTrashBin({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.noteDao.emptyTrashBin();

    Fluttertoast.showToast(
        msg: "Trash emptied successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white.withOpacity(0.87),
        fontSize: 16,
        backgroundColor: Color(0xff222222));
  }
}
