import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class EmptyNoteIllustration extends StatefulWidget {
  @override
  _EmptyNoteIllustrationState createState() => _EmptyNoteIllustrationState();
}

class _EmptyNoteIllustrationState extends State<EmptyNoteIllustration> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Illustration.getNote,
                fit: BoxFit.contain,
                width: SizeHelper.setWidth(size: 220.0),
                height: SizeHelper.setHeight(size: 200.0),
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
                        text: "Write all your important things",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white70,
                            fontSize: SizeHelper.getBodyText1,
                            fontWeight: FontWeight.w500),
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
