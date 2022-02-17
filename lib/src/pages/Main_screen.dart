import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/constants/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int selectedIndex = 0;

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: pages),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomAppBar(
            child: TabBar(
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                indicator: const UnderlineTabIndicator(
                    insets: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                    borderSide:
                        BorderSide(width: 4, color: Colors.deepPurpleAccent)),
                controller: tabController,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  // ignore: prefer_const_constructors
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(CupertinoIcons.home),
                    child: Text(
                      "Home",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(
                      CupertinoIcons.list_bullet,
                    ),
                    child: Text(
                      "Favourites",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(CupertinoIcons.shield_lefthalf_fill),
                    child: Text(
                      "Orders",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(CupertinoIcons.profile_circled),
                    child: FittedBox(
                      child: Text(
                        "Settings",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }
}
