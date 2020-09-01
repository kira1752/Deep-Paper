import 'package:deep_paper/UI/deep_material_app.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main() => runApp(DeepPaperApp());

class DeepPaperApp extends StatefulWidget {
  @override
  _DeepPaperAppState createState() => _DeepPaperAppState();
}

class _DeepPaperAppState extends State<DeepPaperApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getNote),
        context);

    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getTrash),
        context);

    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getPlan),
        context);

    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, Illustration.getFinance),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<DeepPaperDatabase>(
      create: (_) => DeepPaperDatabase(),
      child: DeepMaterialApp(),
    );
  }
}
