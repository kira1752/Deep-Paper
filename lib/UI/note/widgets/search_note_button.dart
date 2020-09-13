import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../business_logic/note/provider/selection_provider.dart';
import '../../../resource/icon_resource.dart';
import '../../../resource/string_resource.dart';

class SearchNoteButton extends StatelessWidget {
  const SearchNoteButton();

  @override
  Widget build(BuildContext context) {
    return Selector2<NoteDrawerProvider, SelectionProvider, bool>(
      selector: (context, drawerProvider, selectionProvider) =>
          drawerProvider.getIndexDrawerItem != 1 &&
          !selectionProvider.getSelection,
      builder: (context, showSearch, searchButton) =>
          Visibility(visible: showSearch, child: searchButton),
      child: IconButton(
          tooltip: StringResource.tooltipSearch,
          icon: IconResource.darkSearch,
          onPressed: () {}),
    );
  }
}
