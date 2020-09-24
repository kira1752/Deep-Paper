import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/note_debounce.dart';
import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/provider/undo_redo_provider.dart';
import '../../../business_logic/note/undo_redo.dart' as undo_redo;
import '../../app_theme.dart';

class UndoRedo extends StatelessWidget {
  final TextEditingController detailController;

  const UndoRedo({@required this.detailController});

  @override
  Widget build(BuildContext context) {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);
    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    final debounceProvider =
        Provider.of<NoteDetailDebounce>(context, listen: false);

    return Selector<NoteDetailProvider, bool>(
      selector: (context, detailProvider) => detailProvider.isTextTyped,
      builder: (context, isTyped, undoRedoButton) =>
          isTyped ? undoRedoButton : const SizedBox(),
      child: Row(
        children: [
          Selector<UndoRedoProvider, bool>(
            selector: (context, provider) => provider.canUndo(),
            builder: (context, canUndo, _) => IconButton(
              icon: Icon(
                Icons.undo,
                color: canUndo
                    ? Theme.of(context).accentColor.withOpacity(0.80)
                    : themeColorOpacity(context: context, opacity: .38),
              ),
              onPressed: canUndo
                  ? () {
                      debounceProvider.cancel();
                      undo_redo.undo(
                        detailProvider: detailProvider,
                        undoRedoProvider: undoRedoProvider,
                        detailController: detailController,
                      );
                    }
                  : null,
            ),
          ),
          Selector<UndoRedoProvider, bool>(
              selector: (context, provider) => provider.canRedo(),
              builder: (context, canRedo, _) => IconButton(
                    icon: Icon(
                      Icons.redo,
                      color: canRedo
                          ? Theme.of(context).accentColor.withOpacity(0.80)
                          : themeColorOpacity(context: context, opacity: .38),
                    ),
                    onPressed: canRedo
                        ? () {
                      debounceProvider.cancel();

                      undo_redo.redo(
                        detailProvider: detailProvider,
                        undoRedoProvider: undoRedoProvider,
                        detailController: detailController,
                      );
                    }
                        : null,
                  )),
        ],
      ),
    );
  }
}
