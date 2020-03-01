import 'package:deep_paper/icons/my_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/note_page.dart';
import 'screen/plan_page.dart';
import 'screen/money_page.dart';
import 'screen/more_page.dart';
import 'package:deep_paper/provider/deep_bottom_provider.dart';

class DeepPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrintSynchronously("Deep Paper Rebuild");
    return ChangeNotifierProvider<DeepBottomProvider>(
      create: (_) => DeepBottomProvider(),
      child: Scaffold(
        body: Selector<DeepBottomProvider, PageController>(
            selector: (context, deepProvider) => deepProvider.controller,
            builder: (context, controller, child) {
              debugPrintSynchronously("Deep Paper Main Menu Rebuild");
              return PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  Provider.of<DeepBottomProvider>(context, listen: false)
                      .setCurrentIndex = index;
                },
                children: <Widget>[
                  KeepAlive(child: NotePage()),
                  KeepAlive(child: PlanPage()),
                  KeepAlive(child: MoneyPage()),
                  KeepAlive(child: MorePage())
                ],
              );
            }),
        bottomNavigationBar: Consumer<DeepBottomProvider>(
            builder: (context, deepProvider, child) {
          debugPrintSynchronously("Bottom Bar Rebuild");
          return BottomNavigationBar(
            //backgroundColor: Color(0xff1A1A1A),
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            selectedItemColor: Colors.blue[400],
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: true,
            currentIndex: deepProvider.currentIndex,// use this to remove appBar's elevation
            onTap: (index) {
              deepProvider.setCurrentIndex = index;
              deepProvider.controller.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(MyIcon.library_books_outline),
                activeIcon: Icon(Icons.library_books),
                title: Text('Note'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MyIcon.event_note_outline),
                activeIcon: Icon(Icons.event_note),
                title: Text('Plan'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MyIcon.chart_line),
                title: Text('Finance'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                title: Text('More'),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class KeepAlive extends StatefulWidget {
  final Widget child;

  const KeepAlive({Key key, this.child}) : super(key: key);

  @override
  _KeepAliveState createState() => new _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin<KeepAlive> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
