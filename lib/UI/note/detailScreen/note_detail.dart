import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/note_debounce.dart';
import '../../../business_logic/note/note_detail_initstate.dart';
import '../../../business_logic/note/note_detail_lifecycle.dart' as lifecycle;
import '../../../business_logic/note/note_detail_normal_save.dart' as save;
import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/provider/undo_redo_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../data/deep.dart';
import '../../../icons/my_icon.dart';
import '../../../resource/icon_resource.dart';
import '../../../resource/string_resource.dart';
import '../../../utility/deep_hooks.dart';
import '../../../utility/extension.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../../widgets/deep_keep_alive.dart';
import '../../widgets/deep_scroll_behavior.dart';
import '../../widgets/deep_snack_bar.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/date_character_counts.dart';
import '../widgets/dialog/note_dialog.dart' as note_dialog;

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

  void dispose(NoteDetailDebounce debounce, UndoRedoProvider undoRedoProvider) {
    debounce.dispose();
    undoRedoProvider.currentTyped.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = useMemoized(
        () => Provider.of<DeepPaperDatabase>(context, listen: false));

    final undoRedoProvider = useMemoized(
        () => Provider.of<UndoRedoProvider>(context, listen: false));

    final detailProvider = useMemoized(
        () => Provider.of<NoteDetailProvider>(context, listen: false));

    final detailController = useTextEditingController();
    final detailFocus = useFocusNode();
    final debounce = useMemoized(() => NoteDetailDebounce());

    useEffect(() {
      init(
          note: note,
          undoRedoProvider: undoRedoProvider,
          detailProvider: detailProvider,
          detailController: detailController,
          detailFocus: detailFocus,
          debounce: debounce);
      return () => dispose(debounce, undoRedoProvider);
    }, const []);

    useWidgetsBindingObserver(
        lifecycle: (state) => lifecycle.check(
            database: database,
            state: state,
            detailProvider: detailProvider,
            folderID: folderID ?? 0,
            folderName: folderName ?? StringResource.mainFolder));

    return WillPopScope(
      onWillPop: () async {
        save.run(
            context: context,
            database: database,
            noteID: detailProvider.getTempNoteID,
            note: detailProvider.getNote,
            detailProvider: detailProvider,
            folderID: folderID ?? 0,
            folderName: folderName ?? StringResource.mainFolder,
            isDeleted: detailProvider.getIsDeleted,
            isCopy: detailProvider.getIsCopy);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                MyIcon.arrow_left,
                color: Theme.of(context).accentColor.withOpacity(0.80),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: DateCharacterCounts(
                    date: date, detail: detailProvider.getDetail))),
        bottomNavigationBar: BottomMenu(
          detailController: detailController,
          onDelete: () {
            if (!detailProvider.getDetail.isNullEmptyOrWhitespace) {
              detailProvider.setIsDeleted = true;

              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 400), () {
                Navigator.maybePop(context);
                showSnack(
                    context: context,
                    icon: info(context: context),
                    description: 'Note moved to Trash Bin');
              });
            } else if (detailProvider.getTempNoteID.isNull &&
                detailProvider.getNote.isNull) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 400), () {
                Navigator.maybePop(context);
                showSnack(
                    context: context,
                    icon: info(context: context),
                    description: 'Empty note deleted');
              });
            } else {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 400), () {
                Navigator.maybePop(context);
              });
            }
          },
          onCopy: () {
            if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
              Navigator.pop(context);

              showSnack(
                  context: context,
                  icon: info(context: context),
                  description: 'Cannot copy empty note');
            } else {
              detailProvider.setIsCopy = true;

              Navigator.pop(context);

              Future.delayed(const Duration(milliseconds: 400), () {
                Navigator.maybePop(context);
                showSnack(
                    context: context,
                    icon: successful(context: context),
                    description: 'Note copied successfully');
              });
            }
          },
          noteInfo: () async {
            final created = await database.noteDao
                .getCreatedDate(detailProvider.getTempNoteID);

            Navigator.pop(context);

            Future.delayed(const Duration(milliseconds: 400), () {
              note_dialog.openNoteInfo(
                  context: context,
                  folderName: folderName ?? StringResource.mainFolder,
                  modified: detailProvider.getNote.isNull
                      ? DateTime.now()
                      : (detailProvider.getNote.detail !=
                              detailProvider.getDetail
                          ? DateTime.now()
                          : detailProvider.getNote.modified),
                  created: detailProvider.getTempNoteID.isNull
                      ? (detailProvider.getNote.isNull
                          ? DateTime.now()
                          : detailProvider.getNote.created)
                      : created);
            });
          },
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
                offset: detailProvider.getDetail.length,
              ));

              if (!undoRedoProvider.canUndo()) {
                undoRedoProvider.tempInitialCursorPosition =
                    detailProvider.getDetail.length;
              }
            },
            child: ListView(
              children: <Widget>[
                DeepKeepAlive(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 16, 16),
                    child: DetailField(
                      detailController: detailController,
                      detailFocus: detailFocus,
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

class DetailField extends StatefulWidget {
  final TextEditingController detailController;
  final FocusNode detailFocus;

  const DetailField(
      {@required this.detailController, @required this.detailFocus});

  @override
  _DetailFieldState createState() => _DetailFieldState();
}

class _DetailFieldState extends State<DetailField> {
  NoteDetailProvider _detailProvider;
  UndoRedoProvider _undoRedoProvider;

  @override
  void initState() {
    super.initState();
    _detailProvider = Provider.of<NoteDetailProvider>(context, listen: false);

    _undoRedoProvider = Provider.of<UndoRedoProvider>(context, listen: false);

    _detailProvider.initialDetailDirection = _detailProvider.getDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDetailProvider, TextDirection>(
        selector: (context, provider) =>
            provider.getDetailDirection ? TextDirection.rtl : TextDirection.ltr,
        builder: (context, direction, _) => TextField(
              controller: widget.detailController,
              focusNode: widget.detailFocus,
              showCursor: true,
              textDirection: direction,
              strutStyle: const StrutStyle(leading: 0.7),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: themeColorOpacity(context: context, opacity: .8),
                  fontWeight: FontWeight.normal,
                  fontSize: SizeHelper.getDetail),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onTap: () {
                _undoRedoProvider.tempInitialCursorPosition =
                    widget.detailController.selection.extentOffset;
              },
              onChanged: (value) => text_field_logic.detail(
                  value: value,
                  detailProvider: _detailProvider,
                  undoRedoProvider: _undoRedoProvider,
                  controller: widget.detailController),
              decoration: const InputDecoration.collapsed(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500)),
            ));
  }
}
