import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/widgets/note_card.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class FolderListView extends StatelessWidget {
  final FolderNoteData folder;

  FolderListView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrintSynchronously("folder: ${folder.id}");

    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchNoteInsideFolder(folder),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: data.isNull
              ? Container()
              : data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(children: <Widget>[
                            Icon(
                              MyIcon.library_books_outline,
                              size: 120.0,
                              color: Colors.white70,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 68.0,
                              child: Material(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 6.0, color: Colors.white70)),
                                child: Padding(
                                  padding: EdgeInsetsResponsive.all(10.0),
                                  child: Icon(
                                    MyIcon.plus,
                                    size: 30.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            )
                          ]),
                          Padding(
                            padding: EdgeInsetsResponsive.only(top: 24.0),
                            child: Text(
                              "Create a new note",
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
                      physics: const ClampingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteCard(
                          index: index,
                          note: data[index],
                          ontap: () {
                            Navigator.of(context).pushNamed("/NoteDetailUpdate",
                                arguments: data[index]);
                          },
                        );
                      }),
        );
      }),
    );
  }
}
