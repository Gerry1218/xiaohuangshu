import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ExpandedText.dart';

class ExpandedPage extends StatefulWidget {
  const ExpandedPage({super.key});

  @override
  State<ExpandedPage> createState() => _ExpandedPageState();
}

class _ExpandedPageState extends State<ExpandedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.all(20),
      child:  ExpandableText(
        text:
            '我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据', maxLines: null,
      ),
    );
  }
}
