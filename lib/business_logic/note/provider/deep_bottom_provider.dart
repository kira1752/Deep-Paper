import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DeepBottomProvider with ChangeNotifier {
  int _currentIndex = 0;
  PageController _controller = PageController(keepPage: false);
  bool _selection = false;

  int get currentIndex => _currentIndex;
  PageController get controller => _controller;
  bool get getSelection => _selection;

  set setSelection(bool selection) {
    _selection = selection;
    notifyListeners();
  }

  set setCurrentIndex(int index) {
    if(_currentIndex != index){
      _currentIndex = index;
      notifyListeners();
    }
  }
}