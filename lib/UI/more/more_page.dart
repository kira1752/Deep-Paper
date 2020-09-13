import 'package:flutter/material.dart';

import '../../utility/size_helper.dart';
import 'widgets/appbar/more_default_appbar.dart';

class MorePage extends StatelessWidget {
  const MorePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: const MoreDefaultAppBar()),
    );
  }
}
