import 'package:flutter/material.dart';

import '../../utility/size_helper.dart';
import 'widgets/appbar/finance_default_appbar.dart';
import 'widgets/empty_finance_illustration.dart';

class FinancePage extends StatelessWidget {
  const FinancePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: const FinanceDefaultAppBar()),
      body: const EmptyFinanceIllustration(),
    );
  }
}
