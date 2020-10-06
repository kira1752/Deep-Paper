import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business_logic/note/provider/deep_bottom_provider.dart';
import '../business_logic/note/provider/fab_provider.dart';
import '../business_logic/note/provider/note_drawer_provider.dart';
import '../business_logic/note/provider/selection_provider.dart';
import '../icons/my_icon.dart';
import '../utility/size_helper.dart';
import '../utility/sizeconfig.dart';
import 'app_theme.dart';
import 'finance/finance_page.dart';
import 'more/more_page.dart';
import 'note/note_page.dart';
import 'plan/plan_page.dart';
import 'widgets/deep_keep_alive.dart';

class DeepPaper extends StatelessWidget {
  const DeepPaper();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavBarProvider>(
          create: (context) => BottomNavBarProvider(),
        ),
        ChangeNotifierProvider<FABProvider>(
          create: (context) => FABProvider(),
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: const _BuildBody(),
        bottomNavigationBar: Selector<BottomNavBarProvider, bool>(
          selector: (context, provider) => provider.getSelection,
          builder: (context, selection, bottomNavigation) => RepaintBoundary(
            child: Visibility(
                visible: selection ? false : true, child: bottomNavigation),
          ),
          child: Selector<BottomNavBarProvider, int>(
            selector: (context, provider) => provider.getCurrentIndex,
            builder: (context, index, _) => BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: SizeHelper.getButton,
              unselectedFontSize: SizeHelper.getButton,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w600),
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor:
                  themeColorOpacity(context: context, opacity: .6),
                  currentIndex: index,
                  onTap: (index) {
                    final deepProvider =
                    Provider.of<BottomNavBarProvider>(context, listen: false);
                    final fabProvider =
                    Provider.of<FABProvider>(context, listen: false);

                    fabProvider.setScrollDown = false;
                    deepProvider.setCurrentIndex = index;
                    deepProvider.controller.jumpToPage(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(MyIcon.square_edit),
                      label: 'Note',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MyIcon.calendar_1),
                      label: 'Plan',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MyIcon.dollar_sign),
                      label: 'Finance',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MyIcon.more_horizontal),
                      label: 'More',
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody();

  @override
  __BuildBodyState createState() => __BuildBodyState();
}

class __BuildBodyState extends State<_BuildBody> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        Provider
            .of<BottomNavBarProvider>(context, listen: false)
            .controller;
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
