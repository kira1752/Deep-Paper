import 'dart:ui';

import 'package:intl/intl.dart' as intl;

TextDirection detectTextDirection(String text) {
  final textDirection = intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;

  return textDirection;
}
