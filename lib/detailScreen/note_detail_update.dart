import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/provider/note_detail_provider.dart';
import 'package:deep_paper/provider/text_controller_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart' show TextUtilsStringExtension;

class _LocalStore {
  String _title;
  String _detail;

  String get getTitle => _title;
  String get getDetail => _detail;

  set setTitle(String title) => _title = title;
  set setDetail(String detail) => _detail = detail;
}

class NoteDetailUpdate extends StatelessWidget {
  final _LocalStore _local = _LocalStore();

  @override
  Widget build(BuildContext context) {
    Note data = ModalRoute.of(context).settings.arguments;
    _local._title = data.title;
    _local._detail = data.detail;

    debugPrintSynchronously("Note Detail Rebuild");

    final String date = DateFormat.yMMMd('en_US').add_jm().format(data.date);

    return ChangeNotifierProvider<NoteDetailProvider>(
      create: (_) => NoteDetailProvider(),
      child: WillPopScope(
        onWillPop: () {
          return _saveNote(context, data);
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.color_lens,
                  color: Colors.white70,
                ),
                tooltip: "Change note color",
                onPressed: () {},
              ),
            ],
            elevation: 0.0,
            centerTitle: true,
          ),
          bottomNavigationBar: _bottomAppBar(date: date),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 16, 16),
                child: _titleField(data: data),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: _detailField(data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _saveNote(BuildContext context, Note data) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final String title = _local.getTitle;
    final String detail = _local.getDetail;

    debugPrintSynchronously("Title: $title");
    debugPrintSynchronously("Detail: $detail");

    if (data.title != title || data.detail != detail) {
      if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
        database.noteDao.updateNote(
            data.copyWith(title: title, detail: detail, date: DateTime.now()));
      } else if (title.isNullEmptyOrWhitespace &&
          detail.isNullEmptyOrWhitespace) {
        database.noteDao.deleteNote(data);
      }
    }

    return true;
  }

  Widget _bottomAppBar({String date}) {
    return BottomAppBar(
      elevation: 0.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              MyIcon.plus_square,
              color: Colors.white70,
            ),
            onPressed: () {},
          ),
          Selector<NoteDetailProvider, bool>(
              selector: (context, detailProvider) => detailProvider.isTextTyped,
              builder: (context, isTyped, child) {
                debugPrintSynchronously("Undo Redo Rebuild");
                return _textOrUndoRedo(
                    context: context, isTyped: isTyped, date: date);
              }),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white70,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _titleField({Note data}) {
    return Provider<TextControllerProvider>(
      create: (context) => TextControllerProvider(),
      dispose: (context, provider) => provider.controller.dispose(),
      child: Selector<TextControllerProvider, TextEditingController>(
          selector: (context, provider) => provider.controller,
          builder: (context, controller, child) {
            controller.text = data.title;
            return TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                if (Provider.of<NoteDetailProvider>(context, listen: false)
                        .isTextTyped ==
                    false) {
                  Provider.of<NoteDetailProvider>(context, listen: false)
                      .setTextState = true;
                }

                _local.setTitle = value;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Title',
              ),
            );
          }),
    );
  }

  Widget _detailField(Note data) {
    return Provider<TextControllerProvider>(
      create: (context) => TextControllerProvider(),
      dispose: (context, provider) => provider.controller.dispose(),
      child: Selector<TextControllerProvider, TextEditingController>(
          selector: (context, provider) => provider.controller,
          builder: (context, controller, child) {
            controller.text = data.detail;
            return TextField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                if (Provider.of<NoteDetailProvider>(context, listen: false)
                        .isTextTyped ==
                    false) {
                  Provider.of<NoteDetailProvider>(context, listen: false)
                      .setTextState = true;
                }

                _local.setDetail = value;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Write your note here...',
              ),
            );
          }),
    );
  }

  Widget _textOrUndoRedo(
      {@required BuildContext context,
      @required bool isTyped,
      @required String date}) {
    if (isTyped) {
      return Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.undo,
              color: Colors.white70,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.redo, color: Colors.white70),
            onPressed: () {},
          )
        ],
      );
    } else {
      return Text(
        "$date",
        style: Theme.of(context).textTheme.bodyText2,
      );
    }
  }
}
