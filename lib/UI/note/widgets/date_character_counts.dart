import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/business_logic/note/text_field_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateCharacterCounts extends StatelessWidget {
  final Future<String> date;
  final String detail;

  DateCharacterCounts({
    @required this.date,
    @required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, bottom: 24.0),
      child: Row(
        children: [
          _TopDate(date: date),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "|",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          FutureProvider<int>(
              create: (context) => TextFieldLogic.countAllAsync(detail),
              builder: (context, widget) {
                return Consumer<int>(
                  builder: (context, count, widget) {
                    if (count == null) {
                      return _TopCount(key: Key("null"), initialCount: 0);
                    } else {
                      return _TopCount(
                          key: Key("available"), initialCount: count);
                    }
                  },
                );
              })
        ],
      ),
    );
  }
}

class _TopDate extends StatefulWidget {
  final Future<String> date;

  _TopDate({@required this.date});

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
                  return SizedBox.shrink();
                } else {
                  return Text(
                    "$date",
                    style: Theme.of(context).textTheme.bodyText2,
                  );
                }
              },
            ));
  }
}

class _TopCount extends StatefulWidget {
  final int initialCount;

  _TopCount({Key key, @required this.initialCount}) : super(key: key);

  @override
  __TopCountState createState() => __TopCountState();
}

class __TopCountState extends State<_TopCount> {
  @override
  initState() {
    super.initState();
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);
    detailProvider.setDetailCount = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDetailProvider, int>(
        selector: (context, provider) => provider.getDetailCount,
        builder: (context, count, widget) {
          return Text(
            "$count characters",
            style: Theme
                .of(context)
                .textTheme
                .bodyText2,
          );
        });
  }
}
