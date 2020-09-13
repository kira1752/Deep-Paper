import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;

// DetectTextDirection Utility class
class DetectTextDirection {
  DetectTextDirection._();

  static bool isRTL({@required String text}) {
    return intl.Bidi.detectRtlDirectionality(text);
  }
}
