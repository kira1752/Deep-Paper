import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class NoteDetailUpdate extends StatefulWidget {
  final Note note;

  NoteDetailUpdate(this.note);

  @override
  _NoteDetailUpdateState createState() => _NoteDetailUpdateState();
}

class _NoteDetailUpdateState extends State<NoteDetailUpdate> {
  String _title;
  String _detail;
  bool _isDeleted;
  String _date;
  TextEditingController _titleController;
  TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _title = widget.note.title ?? "";
    _detail = widget.note.detail ?? "";
    _isDeleted = widget.note.isDeleted;

    _titleController = TextEditingController(text: widget.note.title);
    _detailController = TextEditingController(text: widget.note.detail);

    final DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final DateTime noteDate = DateTime(
        widget.note.date.year, widget.note.date.month, widget.note.date.day);

    _date = now.difference(noteDate).inDays == 0
        ? DateFormat.jm("en_US").format(widget.note.date)
        : (now.difference(noteDate).inDays == 1
            ? "Yesterday, ${DateFormat.jm("en_US").format(widget.note.date)}"
            : (now.difference(noteDate).inDays > 1 &&
                    now.year - widget.note.date.year == 0
                ? DateFormat.MMMd("en_US").add_jm().format(widget.note.date)
                : DateFormat.yMMMd("en_US").add_jm().format(widget.note.date)));

    KeyboardVisibilityNotification().addNewListener(onHide: () {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrintSynchronously("Note Detail Rebuild");

    return ChangeNotifierProvider<NoteDetailProvider>(
      create: (_) => NoteDetailProvider(),
      child: WillPopScope(
        onWillPop: () async {
          NoteCreation.update(
              context: context,
              note: widget.note,
              title: _title,
              detail: _detail,
              isDeleted: _isDeleted);

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white70,
              ),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
            elevation: 0.0,
            centerTitle: true,
          ),
          bottomNavigationBar: BottomMenu(
            date: _date,
            newNote: false,
            onDelete: () {
              _isDeleted = true;
              Navigator.of(context).pop();
              Navigator.of(context).maybePop();

              DeepToast.showToast(description: "Note moved to Trash Bin");
            },
            onCopy: () {
              NoteCreation.create(
                context: context,
                title: _title,
                detail: _detail,
                folderId: widget.note.folderID,
              );
              Navigator.of(context).pop();
              Navigator.of(context).maybePop();

              DeepToast.showToast(description: "Note copied successfully");
            },
          ),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              DeepKeepAlive(
                child: Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(18, 0, 16, 16),
                  child: _titleField(data: widget.note),
                ),
              ),
              DeepKeepAlive(
                child: Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(18, 16, 16, 16),
                  child: _detailField(widget.note),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleField({Note data}) {
    return ChangeNotifierProvider(
      create: (context) => DetectTextDirectionProvider(),
      child: Selector<DetectTextDirectionProvider, TextDirection>(
          selector: (context, provider) =>
              provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
          builder: (context, direction, child) {
            debugPrintSynchronously("Title Field rebuild");

            Provider.of<DetectTextDirectionProvider>(context, listen: false)
                .checkDirection = _title;

            return TextField(
              controller: _titleController,
              textDirection: direction,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white70, fontSize: SizeHelper.getTitle),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                if (Provider.of<NoteDetailProvider>(context, listen: false)
                        .isTextTyped ==
                    false) {
                  Provider.of<NoteDetailProvider>(context, listen: false)
                      .setTextState = true;
                }

                _title = value;

                Provider.of<DetectTextDirectionProvider>(context, listen: false)
                    .checkDirection = _title;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Title',
              ),
            );
          }),
    );
  }

  Widget _detailField(Note data) {
    return ChangeNotifierProvider(
      create: (context) => DetectTextDirectionProvider(),
      child: Selector<DetectTextDirectionProvider, TextDirection>(
          selector: (context, provider) =>
              provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
          builder: (context, direction, child) {
            Provider.of<DetectTextDirectionProvider>(context, listen: false)
                .checkDirection = _detail;

            return TextField(
              controller: _detailController,
              textDirection: direction,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white70, fontSize: SizeHelper.getDescription),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                if (Provider.of<NoteDetailProvider>(context, listen: false)
                        .isTextTyped ==
                    false) {
                  Provider.of<NoteDetailProvider>(context, listen: false)
                      .setTextState = true;
                }

                _detail = value;

                Provider.of<DetectTextDirectionProvider>(context, listen: false)
                    .checkDirection = _detail;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Write your note here...',
              ),
            );
          }),
    );
  }
}
