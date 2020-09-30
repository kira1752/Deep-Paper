import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../utility/extension.dart';
import '../../app_theme.dart';
import '../../transition/widgets/slide_right_widget.dart';

class DateCharacterCounts extends StatelessWidget {
  const DateCharacterCounts();

  @override
  Widget build(BuildContext context) {
    final widget = Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 24.0),
      child: Row(
        children: [
          const _TopDate(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '|',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: themeColorOpacity(context: context, opacity: .54),
                  ),
            ),
          ),
          FutureProvider<int>(
              create: (context) => text_field_logic
                  .countAllAsync(context.read<NoteDetailProvider>().getDetail),
              builder: (context, widget) {
                var count = context.watch<int>();
                return count.isNull
                    ? const _TopCount(key: Key('null'), initialCount: 0)
                    : _TopCount(
                        key: const Key('available'), initialCount: count);
              })
        ],
      ),
    );

    return context.select((NoteDetailProvider value) => value.getDetail.isEmpty)
        ? widget
        : FutureProvider(
            create: (_) =>
                Future.delayed(const Duration(milliseconds: 400), () => true),
            builder: (context, _) {
              var show = context.watch<bool>();

              return SlideRightWidget(
                child: show.isNotNull ? widget : const SizedBox(),
              );
            },
          );
  }
}

class _TopDate extends StatelessWidget {
  const _TopDate();

  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
        create: (context) =>
        context
            .read<NoteDetailProvider>()
            .date,
        builder: (context, widget) {
          var date = context.watch<String>();
          return date.isNull
              ? Text(
            'Loading date...',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2
                .copyWith(
              color:
              themeColorOpacity(context: context, opacity: .54),
            ),
          )
              : Text(
            date.toString(),
            style: Theme
                .of(context)
                .textTheme
                .bodyText2
                .copyWith(
              color:
              themeColorOpacity(context: context, opacity: .54),
            ),
          );
        });
  }
}

class _TopCount extends StatefulWidget {
  final int initialCount;

  const _TopCount({Key key, @required this.initialCount}) : super(key: key);

  @override
  _TopCountState createState() => _TopCountState();
}

class _TopCountState extends State<_TopCount> {
  @override
  void initState() {
    super.initState();

    context
        .read<NoteDetailProvider>()
        .setDetailCount = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.select((NoteDetailProvider value) =>
      value.getDetailCount)} characters',
      style: Theme
          .of(context)
          .textTheme
          .bodyText2
          .copyWith(
        color: themeColorOpacity(context: context, opacity: .54),
      ),
    );
  }
}
