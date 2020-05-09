import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/widgets/note_card.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class NoteListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllNotes(),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 450),
          child: data.isNull
              ? const SizedBox()
              : data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            Illustration.getNote,
                            width: SizeHelper.setWidth(size: 200.0),
                            height: SizeHelper.setHeight(size: 200.0),
                          ),
                          Padding(
                            padding: EdgeInsetsResponsive.only(top: 24.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "Never forget anything\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Colors.white70,
                                          fontSize: SizeHelper.getHeadline5,
                                          fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Write all your important things",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white70,
                                          fontSize: SizeHelper.getBodyText1,
                                          fontWeight: FontWeight.w400),
                                )
                              ]),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DeepKeepAlive(
                          child: NoteCard(
                            key: ValueKey<int>(index),
                            index: index,
                            note: data[index],
                            ontap: () {
                              Navigator.of(context).pushNamed(
                                  "/NoteDetailUpdate",
                                  arguments: data[index]);
                            },
                          ),
                        );
                      }),
        );
      }),
    );
  }
}
