import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utility/illustration.dart';
import '../../../utility/size_helper.dart';
import '../../style/app_theme.dart';

class EmptyTrashIllustration extends StatelessWidget {
  const EmptyTrashIllustration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                Illustration.getTrash,
                fit: BoxFit.contain,
                width: SizeHelper.setWidth(size: 220.0),
                height: SizeHelper.setHeight(size: 200.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Trash is empty',
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
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
