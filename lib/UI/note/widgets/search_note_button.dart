import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
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
                tooltip: StringResource().tooltipSearch,
                icon: IconResource().darkSearch,
                onPressed: () {}),
          );
        });
  }
}
