import 'package:intl/intl.dart' as intl;
import 'package:meta/meta.dart';

// DetectTextDirection Utility class
class DetectTextDirection {
  DetectTextDirection._();

  static bool isRTL({@required String text}) {
    return intl.Bidi.detectRtlDirectionality(text);
  }
}
