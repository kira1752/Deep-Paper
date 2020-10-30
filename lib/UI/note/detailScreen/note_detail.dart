import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/note_debounce.dart';
import '../../../business_logic/note/note_detail_logic.dart';
import '../../../business_logic/note/note_detail_normal_save.dart' as save;
import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/provider/undo_history_provider.dart';
import '../../../business_logic/note/provider/undo_state_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../business_logic/provider/TextControllerValue.dart';
import '../../../business_logic/provider/text_controller_focus_node_value.dart';
import '../../../data/deep.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../../widgets/deep_keep_alive.dart';
import '../../widgets/deep_scroll_behavior.dart';
import 'widgets/bottom_menu.dart';
import 'widgets/date_character_counts.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail();

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail>
    with WidgetsBindingObserver, NoteDetailLogic {
  @override
  Widget build(BuildContext context) {
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
          isDeleted: context.read<NoteDetailProvider>().isDeleted,
          isCopy: context.read<NoteDetailProvider>().isCopy,
        );

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              tooltip: 'Back button',
              padding: EdgeInsets.zero,
              icon: Material(
                color: Theme.of(context).accentColor.withOpacity(.16),
                type: MaterialType.circle,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    FluentIcons.arrow_left_24_filled,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: DateCharacterCounts())),
        bottomNavigationBar: Provider(
          create: (context) => TextControllerValue(detailController),
          child: const BottomMenu(),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (Notification notification) =>
              listenScroll(context, notification),
          child: ScrollConfiguration(
            behavior: const DeepScrollBehavior(),
            child: GestureDetector(
              onTap: onTapNote,
              child: Provider(
                  create: (_) =>
                      TextControllerFocusNodeValue(
                          detailController, detailFocus),
                  child: const _NoteDetailBody()),
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteDetailBody extends StatelessWidget {
  const _NoteDetailBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[
        DeepKeepAlive(
          child: _DetailField(),
        ),
      ],
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.select(
              (TextControllerFocusNodeValue value) =>
          value.textEditingController),
      focusNode: context
          .select((TextControllerFocusNodeValue value) => value.focusNode),
      showCursor: true,
      textDirection:
      context.select((NoteDetailProvider value) => value.detailDirection),
      strutStyle: const StrutStyle(leading: 0.7),
      style: Theme
          .of(context)
          .textTheme
          .bodyText1
          .copyWith(
          color: themeColorOpacity(context: context, opacity: .7),
          fontWeight: FontWeight.normal,
          fontSize: SizeHelper.detail),
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
              debounceProvider: context.read<DetailFieldDebounce>(),
              controller: context
                  .read<TextControllerFocusNodeValue>()
                  .textEditingController),
      decoration: const InputDecoration(
          hintText: 'Write your note here...',
          contentPadding: EdgeInsets.fromLTRB(18, 0, 16, 16),
          hintStyle: TextStyle(fontWeight: FontWeight.w500),
          border: InputBorder.none),
    );
  }
}
