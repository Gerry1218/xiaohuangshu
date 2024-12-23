import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expanded_text.dart';

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
      padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: ExpandableText(
        text: '我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据，我是一个测试的数据',
        maxLines: 2,
      ),
    );
  }
}
