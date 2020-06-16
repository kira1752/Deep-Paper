import 'package:deep_paper/UI/finance/widgets/appbar/finance_default_appbar.dart';
import 'package:deep_paper/UI/finance/widgets/empty_finance_illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class FinancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: FinanceDefaultAppBar()),
      body: EmptyFinanceIllustration(),
    );
  }
}
