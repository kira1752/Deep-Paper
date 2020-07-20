import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/business_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/business_logic/note/undo_redo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Undo extends StatelessWidget {
  final String date;
  final TextEditingController detailController;

  Undo({@required this.date, @required this.detailController});

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDetailProvider, bool>(
        selector: (context, detailProvider) => detailProvider.isTextTyped,
        builder: (context, isTyped, widget) {
          if (isTyped) {
            return Selector<UndoRedoProvider, bool>(
                selector: (context, provider) => provider.canUndo(),
                builder: (context, canUndo, widget) {
                  return IconButton(
                    icon: Icon(
                      Icons.undo,
                      color: canUndo
                          ? Theme.of(context).accentColor.withOpacity(0.80)
                          : Colors.white38,
                    ),
                    onPressed: canUndo
                        ? () => UndoRedoBusinessLogic.undo(
                              context: context,
                              detailController: detailController,
                            )
                        : null,
                  );
                });
          } else {
            return SizedBox.shrink();
          }
        });
  }
}

class Redo extends StatelessWidget {
  final String date;
  final TextEditingController detailController;

  Redo({@required this.date, @required this.detailController});

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDetailProvider, bool>(
        selector: (context, detailProvider) => detailProvider.isTextTyped,
        builder: (context, isTyped, widget) {
          if (isTyped) {
            return Selector<UndoRedoProvider, bool>(
                selector: (context, provider) => provider.canRedo(),
                builder: (context, canRedo, widget) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.redo,
                        color: canRedo
                            ? Theme.of(context).accentColor.withOpacity(0.80)
                            : Colors.white38,
                      ),
                      onPressed: canRedo
                          ? () => UndoRedoBusinessLogic.redo(
                                context: context,
                                detailController: detailController,
                              )
                          : null,
                    ),
                  );
                });
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
