import 'dart:typed_data';

import 'package:deep_paper/data/deep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class NoteListView extends StatelessWidget {
  final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

  @override
  Widget build(BuildContext context) {
    final _database = Provider.of<DeepPaperDatabase>(context, listen: false);
    return StreamProvider<List<Note>>.value(
      value: _database.noteDao.watchAllNotes(),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        if (data == null)
          return Container();
        else if (data.isEmpty) {
          return Center(
              child: Text(
            "CREATE NEW NOTE",
            style: Theme.of(context).textTheme.headline6,
          ));
        } else
          return StaggeredGridView.countBuilder(
            physics: ClampingScrollPhysics(),
            crossAxisCount: 4,
            itemCount: data.length,
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            itemBuilder: (BuildContext context, int index) => Material(
              color: Color(0xff121212),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  debugPrint("Note $index Tapped");
                  Navigator.pushNamed(context, '/NoteDetail');
                },
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /*if (data[index].imagePath != null)
                      Center(
                          child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: FileImage(File("$data[index].imagePath")),
                      )),*/
                        if (data[index].title != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              "${data[index].title}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.80)),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (data[index].detail != null)
                          Text(
                            "${data[index].detail}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white70),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ]),
                ),
              ),
            ),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
          );
      }),
    );
  }
}
