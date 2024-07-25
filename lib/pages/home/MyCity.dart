import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhs/pages/home/FollowPage.dart';

class MyCityPage extends StatefulWidget {
  const MyCityPage({super.key});

  @override
  State<MyCityPage> createState() => _MyCityPageState();
}

class _MyCityPageState extends State<MyCityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FollowPage(categoryId: 8,),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
