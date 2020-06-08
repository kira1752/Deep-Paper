import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/plan/plan_page.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'note/note_page.dart';
import 'screen/money_page.dart';
import 'screen/more_page.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';

class DeepPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidgets.builder(
      width: 393,
      height: 804,
      allowFontScaling: true,
      child: ChangeNotifierProvider<DeepBottomProvider>(
        create: (_) => DeepBottomProvider(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Selector<DeepBottomProvider, PageController>(
              selector: (context, deepProvider) => deepProvider.controller,
              builder: (context, controller, child) {
                return PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: (index) {
                    Provider.of<DeepBottomProvider>(context, listen: false)
                        .setCurrentIndex = index;
                  },
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
                      child: NotePage(),
                    )),
                    DeepKeepAlive(child: PlanPage()),
                    DeepKeepAlive(child: MoneyPage()),
                    DeepKeepAlive(child: MorePage())
                  ],
                );
              }),
          bottomNavigationBar: Selector<DeepBottomProvider, bool>(
              selector: (context, provider) => provider.getSelection,
              builder: (context, selection, child) {
                return Visibility(
                  visible: selection ? false : true,
                  child: Consumer<DeepBottomProvider>(
                      builder: (context, deepProvider, child) {
                    return BottomNavigationBar(
                      elevation: 0.0,
                      backgroundColor: Theme.of(context).canvasColor,
                      type: BottomNavigationBarType.fixed,
                      selectedFontSize: SizeHelper.getButton,
                      unselectedFontSize: SizeHelper.getButton,
                      selectedItemColor: Theme.of(context).accentColor,
                      unselectedItemColor: Colors.white70,
                      currentIndex: deepProvider
                          .currentIndex, // use this to remove appBar's elevation
                      onTap: (index) {
                        deepProvider.setCurrentIndex = index;
                        deepProvider.controller.jumpToPage(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(MyIcon.library_books_outline),
                          activeIcon: Icon(Icons.library_books),
                          title: Text(
                            'Note',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(MyIcon.event_note_outline),
                          activeIcon: Icon(Icons.event_note),
                          title: Text(
                            'Plan',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.pie_chart_outlined),
                          activeIcon: Icon(Icons.pie_chart),
                          title: Text(
                            'Finance',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.more_horiz),
                          title: Text(
                            'More',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    );
                  }),
                );
              }),
        ),
      ),
    );
  }
}
