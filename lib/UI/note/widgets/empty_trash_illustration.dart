import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../utility/illustration.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';

class EmptyTrashIllustration extends StatefulWidget {
  const EmptyTrashIllustration();

  @override
  _EmptyTrashIllustrationState createState() => _EmptyTrashIllustrationState();
}

class _EmptyTrashIllustrationState extends State<EmptyTrashIllustration> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteDrawerProvider>().setTrashExist = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RepaintBoundary(
                child: SvgPicture.asset(
                  Illustration.getTrash,
                  fit: BoxFit.contain,
                  width: SizeHelper.setWidth(size: 220.0),
                  height: SizeHelper.setHeight(size: 200.0),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Trash is empty',
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6
                        .copyWith(
                        color: themeColorOpacity(context: context, opacity: .7),
                        height: 1.5,
                        fontSize: SizeHelper.title,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
