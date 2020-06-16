import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class EmptyFinanceIllustration extends StatefulWidget {
  @override
  _EmptyFinanceIllustrationState createState() =>
      _EmptyFinanceIllustrationState();
}

class _EmptyFinanceIllustrationState extends State<EmptyFinanceIllustration> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(
              Illustration.getFinance,
              fit: BoxFit.contain,
              width: SizeHelper.setWidth(size: 220.0),
              height: SizeHelper.setHeight(size: 200.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Never forget anything\n",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getHeadline5,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "Write all your finance reports",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getBodyText1,
                        fontWeight: FontWeight.w400),
                  )
                ]),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
