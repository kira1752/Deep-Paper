import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/note/widgets/note_card.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class TrashListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllDeletedNotes(),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 450),
          child: data.isNull
              ? Container()
              : data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            MyIcon.trash_empty,
                            size: SizeHelper.setIconSize(size: 120.0),
                            color: Colors.white70,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 14.0),
                            child: Text(
                              "No notes in Trash Bin",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white70,
                                      fontSize: SizeHelper.getTitle),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteCard(
                          index: index,
                          note: data[index],
                          ontap: () {
                            _restoreDialog(context: context, data: data[index]);
                          },
                        );
                      }),
        );
      }),
    );
  }

  Future<void> _restoreDialog(
      {@required BuildContext context, @required Note data}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => Padding(
        padding: EdgeInsets.all(26.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Restore note",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: SizeHelper.getHeadline6,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.87)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
              child: Text(
                "Couldn't open this note. Restore this note to edit the content.",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: SizeHelper.getModalDescription,
                    color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.grey[600].withOpacity(0.2),
                    textColor: Colors.white.withOpacity(0.87),
                    padding: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.grey[600].withOpacity(0.2),
                    textColor: Colors.blueAccent,
                    padding: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                    onPressed: () async {
                      await database.noteDao
                          .updateNote(data.copyWith(isDeleted: false));

                      Navigator.of(context).pop();

                      DeepToast.showToast(
                          description: "Note restored successfully");
                    },
                    child: Text(
                      "Restore",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
