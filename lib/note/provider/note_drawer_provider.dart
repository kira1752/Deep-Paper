import 'package:deep_paper/note/data/deep.dart';
import 'package:flutter/foundation.dart';

class NoteDrawerProvider with ChangeNotifier {
  String _titleFragment = "NOTE";
  int _indexDrawerItem = 0;
  int _indexFolderItem;
  int _defaultItemValue = 4;
  List<Note> _noteList;
  FolderNoteData _folder;
  bool _isTrashExist = false;
  bool _isFolder = false;

  String get getTitleFragment => _titleFragment;
  int get getIndexDrawerItem => _indexDrawerItem;
  int get getIndexFolderItem => _indexFolderItem;
  int get getDefaultItemValue => _defaultItemValue;
  List<Note> get getNoteList => _noteList;
  FolderNoteData get getFolder => _folder;
  bool get isTrashExist => _isTrashExist;
  bool get isFolder => _isFolder;

  set setTitleFragment(String title) {
    if (_titleFragment != title) {
      _titleFragment = title;
      notifyListeners();
    }
  }

  set setIndexDrawerItem(int index) {
    if (_indexDrawerItem != index) {
      _indexDrawerItem = index;
      notifyListeners();
    }
  }

  set setIndexFolderItem(int index) {
    if (_indexFolderItem != index) {
      _indexFolderItem = index;
      notifyListeners();
    }
  }

  set setNoteList(List<Note> noteList) {
    if (_noteList != noteList) {
      _noteList = noteList;
    }
  }

  set setFolder(FolderNoteData folder) {
    if (_folder != folder) {
      _folder = folder;
      notifyListeners();
    }
  }

  set setFolderState(bool value) {
    if (_isFolder != value) {
      _isFolder = value;
      notifyListeners();
    }
  }

  set setTrashExist(bool value) {
    if (_isTrashExist != value) {
      _isTrashExist = value;
      notifyListeners();
    }
  }
}
