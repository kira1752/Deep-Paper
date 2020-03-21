import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl hide TextDirection;

class DetectTextDirectionProvider with ChangeNotifier {
  bool _isRTL = false;

  bool get getDirection => _isRTL;

  set checkDirection(String text) {
    final newIsRTL = intl.Bidi.detectRtlDirectionality(text);

    if (_isRTL != newIsRTL) {
      _isRTL = newIsRTL;
      notifyListeners();
    }
  }
}
