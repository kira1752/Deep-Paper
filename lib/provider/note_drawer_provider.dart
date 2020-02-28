import 'package:flutter/foundation.dart';

class NoteDrawerProvider with ChangeNotifier {
  String _titleFragment = "NOTE";
  int _indexDrawerItem = 0;
  int _folderCount = 4000;
  int _indexFolderItem;
  bool _isFolder = false;

  String get getTitleFragment => _titleFragment;
  int get getIndexDrawerItem => _indexDrawerItem;
  int get getFolderCount => _folderCount;
  int get getIndexFolderItem => _indexFolderItem;
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

  set setFolderState(bool value) {
    if (_isFolder != value) {
      _isFolder = value;
      notifyListeners();
    }
  }
}
