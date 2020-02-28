import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TrashListView extends StatefulWidget {
  @override
  _TrashListViewState createState() => _TrashListViewState();
}

class _TrashListViewState extends State<TrashListView> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        physics: ClampingScrollPhysics(),
        crossAxisCount: 4,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) => Material(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              debugPrint("Note $index Tapped");
              Navigator.pushNamed(context, '/NoteDetail');
            },
            child: Container(
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('$index'),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[800].withOpacity(0.3),
                  //border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      );
  }
}