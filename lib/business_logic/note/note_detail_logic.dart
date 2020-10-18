import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../data/deep.dart';
import 'note_detail_initstate.dart';
import 'note_detail_lifecycle.dart';
import 'provider/note_detail_provider.dart';
import 'provider/undo_history_provider.dart';

mixin NoteDetailLogic<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  TextEditingController detailController;
  FocusNode detailFocus;

  @override
  void initState() {
    super.initState();
    detailController = TextEditingController();
    detailFocus = FocusNode();

    noteDetailInit(
      undoHistoryProvider: context.read<UndoHistoryProvider>(),
      detailProvider: context.read<NoteDetailProvider>(),
      detailController: detailController,
      detailFocus: detailFocus,
    );

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    noteDetailLifecycle(
        database: context.read<DeepPaperDatabase>(),
        state: state,
        detailProvider: context.read<NoteDetailProvider>(),
        folderID: context.read<NoteDetailProvider>().folderID,
        folderName: context.read<NoteDetailProvider>().folderName);
  }

  @override
  void dispose() {
    detailController.dispose();
    detailFocus.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
