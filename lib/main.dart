import 'package:deep_paper/UI/deep_material_app.dart';
import 'package:deep_paper/utility/illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  runApp(DeepMaterialApp());
}
