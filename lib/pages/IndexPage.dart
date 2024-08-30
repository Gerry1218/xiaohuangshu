import 'package:flutter/material.dart';
import 'package:xhs/pages/cart/Cart.dart';
import 'package:xhs/pages/home/Home.dart';
import 'package:xhs/pages/me/Me.dart';
import 'package:xhs/pages/shopping/Shopping.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [Home(), Cart(), Text("ADD"), Shopping(), Me()],
      ),
      bottomNavigationBar: _buildBottom,
    );
  }

  setCurrentIndex(index) {
    debugPrint("setCurrentIndex: $index");
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  setCurrentStyle(index) {
    return _currentIndex == index
        ? const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15)
        : const TextStyle(color: Colors.grey);
  }

  get _buildBottom {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setCurrentIndex(0);
                  },
                  child: Text(
                    "首页",
                    style: setCurrentStyle(0),
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setCurrentIndex(1);
                  },
                  child: Text(
                    "购物",
                    style: setCurrentStyle(1),
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                    onTap: () {
                      setCurrentIndex(2);
                    },
                    child: Container(
                      width: 60,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red),
                        child: const Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        )),
                      ),
                    )),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setCurrentIndex(3);
                  },
                  child: Text(
                    "消息",
                    style: setCurrentStyle(3),
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setCurrentIndex(4);
                  },
                  child: Text(
                    "我",
                    style: setCurrentStyle(4),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
