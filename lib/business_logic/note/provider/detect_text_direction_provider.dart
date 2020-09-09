import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' hide TextDirection;

class DetectTextDirectionProvider with ChangeNotifier {
  bool _isRTL = false;

  bool get getDirection => _isRTL;

  set checkDirection(String text) {
    final newIsRTL = Bidi.detectRtlDirectionality(text);

    if (_isRTL != newIsRTL) {
      _isRTL = newIsRTL;
      notifyListeners();
    }
  }
}
