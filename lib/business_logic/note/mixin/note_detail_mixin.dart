import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../data/deep.dart';
import '../../../utility/debounce.dart';
import '../../provider/note/note_detail_provider.dart';
import '../../provider/note/undo_history_provider.dart';
import '../note_detail_initstate.dart';
import '../note_detail_lifecycle.dart';

mixin NoteDetailMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  TextEditingController detailController;
  FocusNode detailFocus;
  Debounce _scrollDebounce;

  @override
  void initState() {
    super.initState();
    detailController = TextEditingController();
    detailFocus = FocusNode();
    _scrollDebounce = Debounce();

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
    _scrollDebounce.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool listenScroll(BuildContext context, Notification notification) {
    if (notification is UserScrollNotification) {
      final detailProvider = context.read<NoteDetailProvider>();

      switch (notification.direction) {
        case ScrollDirection.forward:
          _scrollDebounce.cancel();
          detailProvider.isNoteScrolling = true;
          return true;
          break;
        case ScrollDirection.reverse:
          _scrollDebounce.cancel();
          detailProvider.isNoteScrolling = true;
          return true;
          break;

        case ScrollDirection.idle:
          _scrollDebounce.run(const Duration(milliseconds: 1000), () {
            detailProvider.isNoteScrolling = false;
          });

          return true;
          break;
      }
    }

    return false;
  }

  void onTapNote() {
    if (context.read<NoteDetailProvider>().isNoteScrolling) {
      return;
    } else {
      if (!detailFocus.hasFocus) {
        detailFocus.requestFocus();
      }
      detailController.selection = TextSelection.fromPosition(TextPosition(
        offset: context.read<NoteDetailProvider>().getDetail.length,
      ));

      if (context.read<UndoHistoryProvider>().isUndoEmpty()) {
        context.read<UndoHistoryProvider>().tempInitCursor =
            context.read<NoteDetailProvider>().getDetail.length;
      }
    }
  }
}
