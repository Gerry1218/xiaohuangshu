import 'package:flutter/material.dart';
import 'package:xhs/pages/home/FollowPage.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _kTabs.length, vsync: this);
  }

  final _kPages =  [
    FollowPage(categoryId: 159),
    FollowPage(categoryId: 8),
    FollowPage(categoryId: 9),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: 165),
    FollowPage(categoryId: 163),
    FollowPage(categoryId: 161),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: -1),
    FollowPage(categoryId: -1),
  ];

  final _kTabs = const <Tab>[
    Tab(text: '推荐'),
    Tab(text: '视频'),
    Tab(text: '直播'),
    Tab(text: '旅行'),
    Tab(text: '美食'),
    Tab(text: '动漫'),
    Tab(text: '户外'),
    Tab(text: '健身塑型'),
    Tab(text: '机车'),
    Tab(text: '情感'),
    Tab(text: '运动'),
    Tab(text: '舞蹈'),
    Tab(text: '游戏'),
    Tab(text: '萌宠'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              // margin: EdgeInsets.only(top: 0),
              width: double.infinity,
              child: _buildTabBar()),
          Expanded(child: _buildTabBarView())
        ],
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
      labelColor: Colors.black87,
      unselectedLabelColor: Colors.black45,
      indicatorColor: Colors.transparent,
      controller: _tabController,
      isScrollable: true,
      tabs: _kTabs,
    );
  }

  _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: _kPages,
    );
  }
}
