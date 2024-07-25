import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhs/constants/color_constants.dart';
import 'package:xhs/pages/home/DiscoverPage.dart';
import 'package:xhs/pages/home/FollowPage.dart';
import 'package:xhs/pages/home/MyCity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  final _kTabs = const [
    Tab(
      text: "关注",
    ),
    Tab(
      text: "发现",
    ),
    Tab(
      text: "南京",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _kTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 24),
              width: double.infinity,
              child: _buildTabBar(context)),
          Expanded(child: _buildTabBarView())
        ],
      ),
    );
  }

  _buildTabItem(String tabName, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.orange,
        width: 40,
        child: Text(
          tabName,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _buildTabBar(context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorDC, // 分割线颜色
            width: 1.0, // 分割线宽度
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            child: Icon(Icons.menu),
          ),
          Container(
            // color: Colors.cyan,
            width: size.width - 120,
            height: 44,
            child: Center(
              child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TabBar(
                    labelColor: const Color(MyColor._pressedColor),
                    unselectedLabelColor: const Color(MyColor._defaultColor),
                    indicatorColor: const Color(MyColor._indicatorColor),
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    controller: _tabController,
                    tabs: _kTabs,
                  )),
            ),
          ),
          Container(
            width: 60,
            child: const Icon(Icons.help),
          )
        ],
      ),
    );
  }

  _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [FollowPage(categoryId: -1), DiscoverPage(), MyCityPage()],
    );
  }
}

class MyColor extends MaterialStateColor {
  const MyColor() : super(_defaultColor);
  static const int _defaultColor = 0xff8C8C8C;
  static const int _pressedColor = 0xff232323;
  static const int _indicatorColor = 0xffDE3148;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}
