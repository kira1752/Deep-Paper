import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utility/illustration.dart';
import '../../../utility/size_helper.dart';
import '../../style/app_theme.dart';

class EmptyPlanIllustration extends StatelessWidget {
  const EmptyPlanIllustration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: FittedBox(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                Illustration.getPlan,
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
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Too busy tomorrow?\n',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: themeColorOpacity(
                                context: context, opacity: .7),
                            height: 2.0,
                            fontSize: SizeHelper.headline5,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Plan your day here efficiently',
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
