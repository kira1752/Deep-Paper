import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/provider/note/detect_text_direction_provider.dart';
import '../../../../business_logic/provider/text_controller_provider.dart';
import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';

class PlanNameField extends StatelessWidget {
  const PlanNameField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: MultiProvider(
        providers: [
          Provider<TextControllerProvider>(
            create: (context) => TextControllerProvider(),
            dispose: (context, provider) => provider.controller.dispose(),
          ),
          ChangeNotifierProvider(
              create: (context) => DetectTextDirectionProvider())
        ],
        child: Consumer<TextControllerProvider>(
            builder: (context, textControllerProvider, _) {
          return Selector<DetectTextDirectionProvider, TextDirection>(
              selector: (context, provider) =>
                  provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
              builder: (context, direction, _) => TextField(
                    controller: textControllerProvider.controller,
                    autofocus: true,
                    textDirection: direction,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: themeColorOpacity(context: context, opacity: .7),
                        fontSize: SizeHelper.planTitle),
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'My plan is...',
                    ),
                  ));
        }),
      ),
    );
  }
}
