import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../data/deep.dart';

class SelectionProvider with ChangeNotifier {
  bool _selection = false;
  final HashMap<int, Note> _selected = HashMap();

  bool get getSelection => _selection;

  Map<int, Note> get getSelected => _selected;

  void setFirstSelected({@required int key, @required Note note}) {
    _selected[key] = note;
  }

  void setSelected({@required int key, @required Note note}) {
    _selected[key] = note;
    notifyListeners();
  }

  void remove({@required int key}) {
    _selected.remove(key);
    notifyListeners();
  }

  set setSelection(bool value) {
    if (_selection != value) {
      _selection = value;
      notifyListeners();
    }
  }
}
