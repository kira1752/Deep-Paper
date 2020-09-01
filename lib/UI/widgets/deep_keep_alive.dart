import 'package:flutter/material.dart';

class DeepKeepAlive extends StatefulWidget {
  final Widget child;

  const DeepKeepAlive({Key key, this.child}) : super(key: key);

  @override
  _DeepKeepAliveState createState() => _DeepKeepAliveState();
}

class _DeepKeepAliveState extends State<DeepKeepAlive>
    with AutomaticKeepAliveClientMixin<DeepKeepAlive> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
