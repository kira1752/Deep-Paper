import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyNoteIllustration extends StatefulWidget {
  @override
  _EmptyNoteIllustrationState createState() => _EmptyNoteIllustrationState();
}

class _EmptyNoteIllustrationState extends State<EmptyNoteIllustration> {
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
                  Illustration.getNote,
                  fit: BoxFit.contain,
                  width: SizeHelper.setWidth(size: 220.0),
                  height: SizeHelper.setHeight(size: 200.0),
                ),
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
                            color: Colors.white70,
                            height: 2.0,
                            fontSize: SizeHelper.getHeadline5,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Start writing all your ideas here',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white70,
                            height: 1.5,
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
