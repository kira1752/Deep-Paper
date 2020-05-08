import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeepToast {
  static Future<bool> showToast({@required String description}) {
    return Fluttertoast.showToast(
        msg: description,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white.withOpacity(0.87),
        fontSize: SizeHelper.getToastText,
        backgroundColor: Color(0xff313131));
  }
}
