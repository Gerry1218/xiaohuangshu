import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridviewPaging extends StatefulWidget {
  const GridviewPaging({super.key});

  @override
  State<GridviewPaging> createState() => _GridviewPagingState();
}

class _GridviewPagingState extends State<GridviewPaging> {

  final List<Map<String, dynamic>> _menuData = [
    {"name": "菜单0", "img": "assets/images/jn_1.png"},
    {"name": "菜单1", "img": "assets/images/jn_2.png"},
    {"name": "菜单2", "img": "assets/images/jn_3.png"},
    {"name": "菜单3", "img": "assets/images/jn_4.png"},
    {"name": "菜单4", "img": "assets/images/jn_4.png"},
    {"name": "菜单5", "img": "assets/images/jn_3.png"},
    {"name": "菜单6", "img": "assets/images/jn_2.png"},
  ];
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.greenAccent,
          title: const Text(
            '菜单',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            height: 100,
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Expanded(child: getPageBody()),
                Container(
                  height: 15,
                  alignment: Alignment.center,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: (_menuData.length % 4) > 0
                          ? (_menuData.length ~/ 4) + 1
                          : (_menuData.length ~/ 4),
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: const Alignment(0, .5),
                          height: 15,
                          width: 15,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: _pageIndex == index
                                ? Colors.greenAccent
                                : Colors.grey,
                            child: Container(
                              alignment: const Alignment(0, .5),
                              width: 10,
                              height: 10,
                            ),
                          ),
                        );
                      }),
                )
              ],
            )));
  }

  Widget getPageBody() {
    return PageView.builder(
      itemCount: (_menuData.length % 4) > 0
          ? (_menuData.length ~/ 4) + 1
          : (_menuData.length ~/ 4),
      onPageChanged: (index) {
        _pageIndex = index;
        setState(() {});
      },
      itemBuilder: (BuildContext context, int index) {
        return ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (index < (_menuData.length ~/ 4))
                  ? 4
                  : (_menuData.length % 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, position) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        _menuData[index * 4 + position]['img'].toString(),
                        width: 40,
                        height: 40,
                      ),
                      Text(
                        _menuData[index * 4 + position]['name'].toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
