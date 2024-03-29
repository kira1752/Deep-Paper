import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utility/illustration.dart';
import '../../../utility/size_helper.dart';
import '../../style/app_theme.dart';

class EmptyNoteIllustration extends StatelessWidget {
  const EmptyNoteIllustration();

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
                Illustration.getNote,
                fit: BoxFit.contain,
                width: SizeHelper.setWidth(size: 220.0),
                height: SizeHelper.setHeight(size: 200.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: RichText(
                    maxLines: null,
                    strutStyle: const StrutStyle(leading: 1.0),
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Feel excited today?\n',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: themeColorOpacity(
                                context: context, opacity: .7),
                            height: 2.0,
                            fontSize: SizeHelper.headline5,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Start writing all your ideas here',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: themeColorOpacity(
                                  context: context, opacity: .7),
                              height: 1.5,
                              fontSize: SizeHelper.bodyText1,
                            ),
                      )
                    ]),
                    textAlign: TextAlign.center,
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
