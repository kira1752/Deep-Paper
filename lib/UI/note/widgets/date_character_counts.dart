import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../utility/extension.dart';

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
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          FutureProvider<int>(
              create: (context) => text_field_logic.countAllAsync(detail),
              builder: (context, widget) {
                return Consumer<int>(
                  builder: (context, count, noTextCount) => count.isNull
                      ? noTextCount
                      : _TopCount(
                          key: const Key('available'), initialCount: count),
                  child: const _TopCount(key: Key('null'), initialCount: 0),
                );
              })
        ],
      ),
    );
  }
}

class _TopDate extends StatefulWidget {
  final Future<String> date;

  const _TopDate({@required this.date});

  @override
  __TopDateState createState() => __TopDateState();
}

class __TopDateState extends State<_TopDate> {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
        create: (context) => widget.date,
        builder: (context, widget) => Consumer<String>(
              builder: (context, date, widget) {
                if (date == null) {
                  return Text(
                    'Loading date...',
                    style: Theme.of(context).textTheme.bodyText2,
                  );
                } else {
                  return Text(
                    '$date',
                    style: Theme.of(context).textTheme.bodyText2,
                  );
                }
              },
            ));
  }
}

class _TopCount extends StatefulWidget {
  final int initialCount;

  const _TopCount({Key key, @required this.initialCount}) : super(key: key);

  @override
  __TopCountState createState() => __TopCountState();
}

class __TopCountState extends State<_TopCount> {
  @override
  void initState() {
    super.initState();
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);
    detailProvider.setDetailCount = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDetailProvider, int>(
        selector: (context, provider) => provider.getDetailCount,
        builder: (context, count, _) =>
            Text(
              '$count characters',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2,
            ));
  }
}
