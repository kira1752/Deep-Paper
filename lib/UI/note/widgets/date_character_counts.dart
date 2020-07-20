import 'package:flutter/material.dart';

class DateCharacterCounts extends StatelessWidget {
  final String date;
  final String detail;

  DateCharacterCounts({@required this.date, @required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, bottom: 24.0),
      child: Row(
        children: [
          Text(
            "$date",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("|"),
          ),
          Text(
              "${detail.replaceAll(RegExp(r"\s+\b|\b\s|\s|\b"), "").length} characters")
        ],
      ),
    );
  }
}
