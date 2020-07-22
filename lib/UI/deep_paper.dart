import 'package:deep_paper/UI/finance/finance_page.dart';
import 'package:deep_paper/UI/more/more_page.dart';
import 'package:deep_paper/UI/note/note_page.dart';
import 'package:deep_paper/UI/plan/plan_page.dart';
import 'package:deep_paper/UI/widgets/deep_keep_alive.dart';
import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:deep_paper/utility/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DeepPaper extends StatefulWidget {
  @override
  _DeepPaperState createState() => _DeepPaperState();
}

class _DeepPaperState extends State<DeepPaper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage(Illustration.getNote), context);

    precacheImage(AssetImage(Illustration.getTrash), context);

    precacheImage(AssetImage(Illustration.getPlan), context);

    precacheImage(AssetImage(Illustration.getFinance), context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Theme.of(context).canvasColor,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<DeepBottomProvider>(
            create: (context) => DeepBottomProvider(),
          ),
          ChangeNotifierProvider<FABProvider>(
            create: (context) => FABProvider(),
          )
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _BuildBody(),
          bottomNavigationBar: Selector<DeepBottomProvider, bool>(
              selector: (context, provider) => provider.getSelection,
              builder: (context, selection, child) {
                final deepProvider =
                    Provider.of<DeepBottomProvider>(context, listen: false);
                final fabProvider =
                    Provider.of<FABProvider>(context, listen: false);

                return RepaintBoundary(
                  child: Visibility(
                      visible: selection ? false : true,
                      child: Selector<DeepBottomProvider, int>(
                        selector: (context, provider) =>
                            provider.getCurrentIndex,
                        builder: (context, index, widget) =>
                            BottomNavigationBar(
                          elevation: 0.0,
                          backgroundColor: Theme.of(context).canvasColor,
                          type: BottomNavigationBarType.fixed,
                          selectedFontSize: SizeHelper.getButton,
                          unselectedFontSize: SizeHelper.getButton,
                          selectedItemColor: Theme.of(context).accentColor,
                          unselectedItemColor: Colors.white70,
                          currentIndex: index,
                          onTap: (index) {
                            fabProvider.setScroll = false;
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
                        ),
                      )),
                );
              }),
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
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
            .of<DeepBottomProvider>(context, listen: false)
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
              child: NotePage(),
            )),
        DeepKeepAlive(child: PlanPage()),
        DeepKeepAlive(child: FinancePage()),
        DeepKeepAlive(child: MorePage())
      ],
    );
  }
}
