import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/business_logic/text_field_logic.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  TextEditingController _titleController;
  TextEditingController _detailController;
  FocusNode _titleFocus;
  FocusNode _detailFocus;
  bool _keyboardVisible = false;

  final String _date = DateFormat.jm('en_US').format(DateTime.now());

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _detailController = TextEditingController();
    _titleFocus = FocusNode();
    _detailFocus = FocusNode();

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    undoRedoProvider.setInitialTitle = "";
    undoRedoProvider.setInitialDetail = "";

    KeyboardVisibility.onChange.listen((visible) {
      _keyboardVisible = visible;
      if (visible == false) {
        if (_titleFocus.hasFocus) {
          _titleFocus.unfocus();
        } else if (_detailFocus.hasFocus) {
          _detailFocus.unfocus();
        }
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _titleFocus.dispose();
    _detailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FolderNoteData folder = ModalRoute.of(context).settings.arguments;
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: Color(0xff202020),
        ),
        primaryColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        bottomAppBarColor: Theme.of(context).bottomAppBarColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: WillPopScope(
        onWillPop: () async {
          NoteCreation.create(
              context: context,
              title: detailProvider.getTitle,
              detail: detailProvider.getDetail,
              folderID: folder.isNotNull ? folder.id : 0,
              folderName: folder.isNotNull ? folder.name : "Main folder");

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
            newNote: true,
            titleController: _titleController,
            detailController: _detailController,
            titleFocus: _titleFocus,
            detailFocus: _detailFocus,
          ),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              DeepKeepAlive(
                child: Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(18, 0, 16, 16),
                  child: _titleField(),
                ),
              ),
              DeepKeepAlive(
                child: Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(18, 16, 16, 16),
                  child: _detailField(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleField() {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    return Selector<NoteDetailProvider, TextDirection>(
        selector: (context, provider) =>
            provider.getTitleDirection ? TextDirection.rtl : TextDirection.ltr,
        builder: (context, direction, child) {
          return TextField(
            controller: _titleController,
            focusNode: _titleFocus,
            readOnly: !_keyboardVisible,
            onTap: () {
              if (_keyboardVisible == false) {
                SystemChannels.textInput.invokeMethod('TextInput.show');
              }
            },
            textDirection: direction,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white70, fontSize: SizeHelper.getTitle),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) => TextFieldLogic.title(
                value: value,
                detailProvider: detailProvider,
                undoRedoProvider: undoRedoProvider),
            decoration: InputDecoration.collapsed(
              hintText: 'Title',
            ),
          );
        });
  }

  Widget _detailField() {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    return Selector<NoteDetailProvider, TextDirection>(
        selector: (context, provider) =>
            provider.getDetailDirection ? TextDirection.rtl : TextDirection.ltr,
        builder: (context, direction, child) {
          return TextField(
            controller: _detailController,
            focusNode: _detailFocus,
            readOnly: !_keyboardVisible,
            onTap: () {
              if (_keyboardVisible == false) {
                SystemChannels.textInput.invokeMethod('TextInput.show');
              }
            },
            textDirection: direction,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white70, fontSize: SizeHelper.getDescription),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) => TextFieldLogic.detail(
                value: value,
                detailProvider: detailProvider,
                undoRedoProvider: undoRedoProvider),
            decoration: InputDecoration.collapsed(
              hintText: 'Write your note here...',
            ),
          );
        });
  }
}
