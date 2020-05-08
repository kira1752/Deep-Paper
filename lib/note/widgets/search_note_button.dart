import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
        selector: (context, provider) => provider.getIndexDrawerItem != 1,
        builder: (context, showSearch, child) {
          return Visibility(
            visible: showSearch,
            child: IconButton(
                icon: Icon(
                  MyIcon.search,
                  color: Colors.white.withOpacity(0.87),
                ),
                onPressed: () {}),
          );
        });
  }
}
