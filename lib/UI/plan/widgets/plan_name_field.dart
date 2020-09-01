import 'package:deep_paper/business_logic/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/business_logic/note/provider/text_controller_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            builder: (context, textControllerProvider, child) {
          return Selector<DetectTextDirectionProvider, TextDirection>(
              selector: (context, provider) =>
                  provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
              builder: (context, direction, child) {
                return TextField(
                  controller: textControllerProvider.controller,
                  textDirection: direction,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white70, fontSize: SizeHelper.getPlanTitle),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'My plan is...',
                  ),
                );
              });
        }),
      ),
    );
  }
}
