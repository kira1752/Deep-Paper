import 'package:flutter/material.dart';

class TrashListView extends StatefulWidget {
  @override
  _TrashListViewState createState() => _TrashListViewState();
}

class _TrashListViewState extends State<TrashListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
    
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
      );
  }
}