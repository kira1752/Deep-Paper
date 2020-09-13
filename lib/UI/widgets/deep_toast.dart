import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utility/size_helper.dart';

// DeepToast Utility class
class DeepToast {
  static Future<bool> showToast({@required String description}) {
    return Fluttertoast.showToast(
        msg: description,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white.withOpacity(0.87),
        fontSize: SizeHelper.getToastText,
        backgroundColor: const Color(0xff36373b));
  }
}
