import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;

class DetectTextDirection {
  static bool isRTL({@required String text}) {
    return intl.Bidi.detectRtlDirectionality(text);
  }
}
