import 'package:deep_paper/UI/deep_material_app.dart';
import 'package:deep_paper/data/deep.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(DeepPaperApp());

class DeepPaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DeepPaperDatabase>(
      create: (_) => DeepPaperDatabase(),
      child: DeepMaterialApp(),
    );
  }
}
