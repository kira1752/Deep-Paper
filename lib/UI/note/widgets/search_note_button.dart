import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/provider/note/note_drawer_provider.dart';
import '../../../business_logic/provider/note/selection_provider.dart';
import '../../../resource/icon_resource.dart';
import '../../../resource/string_resource.dart';

class SearchNoteButton extends StatelessWidget {
  const SearchNoteButton();

  @override
  Widget build(BuildContext context) {
    final showSearch =
        context.select((SelectionProvider value) => !value.getSelection) &&
            context.select(
                (NoteDrawerProvider value) => value.getIndexDrawerItem != 1);

    return Visibility(visible: showSearch, child: const _SearchNoteButton());
  }
}

class _SearchNoteButton extends StatelessWidget {
  const _SearchNoteButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: StringResource.tooltipSearch,
        icon: search(context: context),
        onPressed: () {});
  }
}
