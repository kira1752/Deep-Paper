import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/note_debounce.dart';
import '../../../business_logic/note/note_detail_initstate.dart';
import '../../../business_logic/note/note_detail_lifecycle.dart' as lifecycle;
import '../../../business_logic/note/note_detail_normal_save.dart' as save;
import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/provider/undo_history_provider.dart';
import '../../../business_logic/note/provider/undo_state_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../business_logic/provider/TextControllerValue.dart';
import '../../../business_logic/provider/text_controller_focus_node_value.dart';
import '../../../data/deep.dart';
import '../../../icons/my_icon.dart';
import '../../../utility/deep_hooks.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../../widgets/deep_keep_alive.dart';
import '../../widgets/deep_scroll_behavior.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/date_character_counts.dart';

class NoteDetail extends HookWidget {
  final int folderID;
  final String folderName;
  final Note note;
  final Future<String> date;

  const NoteDetail(
      {@required this.folderID,
      @required this.folderName,
      @required this.note,
      @required this.date});

  @override
  Widget build(BuildContext context) {
    final detailController = useTextEditingController();
    final detailFocus = useFocusNode();

    useEffect(() {
      init(
          note: note,
          undoHistoryProvider: context.read<UndoHistoryProvider>(),
          detailProvider: context.read<NoteDetailProvider>(),
          detailController: detailController,
          detailFocus: detailFocus,
          folderName: folderName);
      return;
    }, const []);

    useWidgetsBindingObserver(
        lifecycle: (state) => lifecycle.check(
            database: context.read<DeepPaperDatabase>(),
            state: state,
            detailProvider: context.read<NoteDetailProvider>(),
            folderID: context.read<NoteDetailProvider>().folderID,
            folderName: context.read<NoteDetailProvider>().folderName));

    return WillPopScope(
      onWillPop: () async {
        save.run(
          context: context,
          database: context.read<DeepPaperDatabase>(),
          noteID: context.read<NoteDetailProvider>().getTempNoteID,
          note: context.read<NoteDetailProvider>().getNote,
          detailProvider: context.read<NoteDetailProvider>(),
          folderID: context.read<NoteDetailProvider>().folderID,
          folderName: context.read<NoteDetailProvider>().folderName,
          isDeleted: context.read<NoteDetailProvider>().getIsDeleted,
          isCopy: context.read<NoteDetailProvider>().getIsCopy,
        );

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                MyIcon.arrow_left,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.8),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: DateCharacterCounts(
                  date: date,
                  detail: context
                      .read<NoteDetailProvider>()
                      .getDetail,
                ))),
        bottomNavigationBar: Provider(
          create: (context) => TextControllerValue(detailController),
          child: const BottomMenu(),
        ),
        body: ScrollConfiguration(
          behavior: const DeepScrollBehavior(),
          child: GestureDetector(
            onTap: () {
              if (!detailFocus.hasFocus) {
                detailFocus.requestFocus();
              }
              detailController.selection =
                  TextSelection.fromPosition(TextPosition(
                    offset: context
                        .read<NoteDetailProvider>()
                        .getDetail
                        .length,
                  ));

              if (context.read<UndoHistoryProvider>().isUndoEmpty()) {
                context
                    .read<UndoHistoryProvider>()
                    .tempInitCursor =
                    context
                        .read<NoteDetailProvider>()
                        .getDetail
                        .length;
              }
            },
            child: ListView(
              children: <Widget>[
                DeepKeepAlive(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 16, 16),
                    child: Provider(
                      create: (_) =>
                          TextControllerFocusNodeValue(
                              detailController, detailFocus),
                      child: const _DetailField(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailField extends HookWidget {
  const _DetailField();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context
          .read<NoteDetailProvider>()
          .initialDetailDirection =
          context
              .read<NoteDetailProvider>()
              .getDetail;
      return;
    });

    return TextField(
      controller:
      context
          .read<TextControllerFocusNodeValue>()
          .textEditingController,
      focusNode: context
          .read<TextControllerFocusNodeValue>()
          .focusNode,
      showCursor: true,
      textDirection:
      context.select((NoteDetailProvider value) => value.detailDirection),
      strutStyle: const StrutStyle(leading: 0.7),
      style: Theme
          .of(context)
          .textTheme
          .bodyText1
          .copyWith(
          color: themeColorOpacity(context: context, opacity: .8),
          fontWeight: FontWeight.normal,
          fontSize: SizeHelper.getDetail),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onTap: () {
        context
            .read<UndoHistoryProvider>()
            .tempInitCursor = context
            .read<TextControllerFocusNodeValue>()
            .textEditingController
            .selection
            .extentOffset;
      },
      onChanged: (value) =>
          text_field_logic.detail(
              value: value,
              detailProvider: context.read<NoteDetailProvider>(),
              undoHistory: context.read<UndoHistoryProvider>(),
              undoState: context.read<UndoStateProvider>(),
              debounceProvider: context.read<NoteDetailDebounce>(),
              controller: context
                  .read<TextControllerFocusNodeValue>()
                  .textEditingController),
      decoration: const InputDecoration.collapsed(
          hintText: 'Write your note here...',
          hintStyle: TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
