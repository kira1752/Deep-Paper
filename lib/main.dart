import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'UI/DeepPaper.dart';
import 'utility/illustration.dart';
import 'utility/load_svg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;

  Future.wait([
    preloadSvg(Illustration.getNote),
    preloadSvg(Illustration.getTrash),
    preloadSvg(Illustration.getPlan),
    preloadSvg(Illustration.getFinance),
  ]).then((value) => runApp(const OverlaySupport(child: DeepPaper())));
}
