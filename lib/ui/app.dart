import 'package:gghub/common/defination.dart';
import 'package:gghub/ui/explore_add.dart';
import 'package:gghub/ui/explore_option.dart';
import 'package:gghub/ui/settings.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    final selectedItem = TabItem.values[_selectedIndex];

    return MaterialApp(
      title: 'Github',
      home: Scaffold(
        appBar: AppBar(
          title: Text(titleForTabItem(selectedItem)),
          leading: leadingForTabItem(selectedItem),
          actions: actionsForTabItem(selectedItem),
          automaticallyImplyLeading: false,
        ),
        body: PageView(
            controller: pageController,
            children: TabItem.values.map((item) {
              return pageForTabItem(item);
            }).toList(),
            onPageChanged: (int index) {
              setState(() => _selectedIndex = index);
            }),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Theme.of(context).primaryColor,
            items: TabItem.values.map((item) {
              return BottomNavigationBarItem(
                title: Text(titleForTabItem(item)),
                icon: iconForTabItem(item),
              );
            }).toList(),
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
                pageController.jumpToPage(index);
              });
            }),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        fontFamily: 'PingFang SC',
      ),
    );
  }

  MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (BuildContext context) {
        return widget;
      });

  Widget leadingForTabItem(TabItem item) {
    Widget result;

    switch (item) {
      case TabItem.news:
        break;
      case TabItem.explore:
        result = GestureDetector(
          onTap: () {
            Navigator.push(context, _route(ExploreAdd()));
          },
          child: Icon(Icons.add),
        );
        break;
      case TabItem.search:
        break;
      case TabItem.profile:
        result = GestureDetector(
          onTap: () {
            Navigator.push(context, _route(SettingsPage()));
          },
          child: Icon(Icons.settings),
        );
        break;
    }
    return result;
  }

  List<Widget> actionsForTabItem(TabItem item) {
    final result = <Widget>[];
    switch (item) {
      case TabItem.news:
        break;
      case TabItem.explore:
        result.add(GestureDetector(
          onTap: () {
            Navigator.push(context, _route(ExploreSettingsPage()));
          },
          child: Icon(Icons.settings_applications),
        ));
        break;
      case TabItem.search:
        break;
      case TabItem.profile:
        break;
    }
    return result;
  }
}
