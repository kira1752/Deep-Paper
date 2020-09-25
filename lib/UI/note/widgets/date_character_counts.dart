import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../utility/extension.dart';
import '../../app_theme.dart';

class DateCharacterCounts extends StatelessWidget {
  final Future<String> date;
  final String detail;

  const DateCharacterCounts({
    @required this.date,
    @required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 24.0),
      child: Row(
        children: [
          _TopDate(date: date),
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
              create: (context) => text_field_logic.countAllAsync(detail),
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
  }
}

class _TopDate extends StatelessWidget {
  final Future<String> date;

  const _TopDate({@required this.date});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
        create: (context) => date,
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

class _TopCount extends HookWidget {
  final int initialCount;

  const _TopCount({Key key, @required this.initialCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context
          .read<NoteDetailProvider>()
          .setDetailCount = initialCount;
      return;
    }, const []);

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
