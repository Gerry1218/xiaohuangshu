import 'package:flutter/material.dart';

import 'close_swipedown_widget.dart';

class TestPage1 extends StatelessWidget {
  const TestPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CloseOnSwipeDownWidget(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 500,
            ), // 让组件内容在页面底部
            Container(
              height: 500,
              color: Colors.blue,
              alignment: Alignment.bottomCenter,
              child: const Center(
                child: Text('我是内容'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
