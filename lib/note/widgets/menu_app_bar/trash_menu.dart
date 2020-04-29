import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/business_logic/trash_management.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

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
                  if (choice == 0) TrashManagement.empty(context: context);
                },
                padding: EdgeInsetsResponsive.all(18.0),
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
                            style: TextStyle(fontSize: SizeHelper.getBodyText1),
                          ),
                        ))
                  ];
                }),
          );
        },
      ),
    );
  }
}
