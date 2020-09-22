import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utility/illustration.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';

class EmptyFinanceIllustration extends StatelessWidget {
  const EmptyFinanceIllustration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.contain,
                child: RepaintBoundary(
                  child: SvgPicture.asset(
                    Illustration.getFinance,
                    fit: BoxFit.contain,
                    width: SizeHelper.setWidth(size: 220.0),
                    height: SizeHelper.setHeight(size: 200.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: RichText(
                    strutStyle: const StrutStyle(leading: 1.0),
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Never forget anything\n',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: themeColorOpacity(
                                context: context, opacity: .7),
                            height: 2.0,
                            fontSize: SizeHelper.getHeadline5,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Write all your finance reports',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: themeColorOpacity(
                                  context: context, opacity: .7),
                              height: 1.5,
                              fontSize: SizeHelper.getBodyText1,
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
