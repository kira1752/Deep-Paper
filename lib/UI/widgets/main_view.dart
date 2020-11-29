import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/provider/note/deep_bottom_provider.dart';
import '../../business_logic/provider/note/note_drawer_provider.dart';
import '../../business_logic/provider/note/selection_provider.dart';
import '../finance/finance_page.dart';
import '../more/more_page.dart';
import '../note/note_page.dart';
import '../plan/plan_page.dart';
import 'deep_keep_alive.dart';

class MainView extends StatefulWidget {
  const MainView();
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        Provider.of<MainNavigationProvider>(context, listen: false).controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: <Widget>[
        DeepKeepAlive(
            child: MultiProvider(
          providers: [
            ChangeNotifierProvider<NoteDrawerProvider>(
              create: (context) => NoteDrawerProvider(),
            ),
            ChangeNotifierProvider<SelectionProvider>(
              create: (context) => SelectionProvider(),
            )
          ],
          child: const NotePage(),
        )),
        const DeepKeepAlive(child: PlanPage()),
        const DeepKeepAlive(child: FinancePage()),
        const DeepKeepAlive(child: MorePage())
      ],
    );
  }
}
