import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_support/overlay_support.dart';

import 'UI/deep_material_app.dart';
import 'utility/illustration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getNote),
      null);

  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getTrash),
      null);

  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getPlan),
      null);

  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getFinance),
      null);

  GestureBinding.instance.resamplingEnabled = true;
  runApp(const OverlaySupport(child: DeepMaterialApp()));
}
