import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollTabPage extends StatefulWidget {
  const ScrollTabPage({super.key});

  @override
  State<ScrollTabPage> createState() => _ScrollTabPageState();
}

class _ScrollTabPageState extends State<ScrollTabPage> {
  final _kPages = const [
    Center(child: Icon(Icons.add, size: 64, color: Colors.teal)),
    Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.orange)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.pink)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.amber)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.greenAccent)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.indigoAccent)),
  ];

  final _kTabs = const <Tab>[
    Tab(text: 'NK'),
    Tab(text: 'ActiveTools'),
    Tab(text: 'Coxmate'),
    Tab(text: 'Concept2'),
    Tab(text: 'Croker'),
    Tab(text: 'Hudson'),
    Tab(text: 'Swift'),
    Tab(text: 'Rowshop'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _kPages.length,
        child: Container(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Scroll Tab page"),
              bottom: TabBar(
                isScrollable: true, // 不设置的话，tab多的话可能无法显示
                tabs: _kTabs,
              ),
            ),
            body: TabBarView(
              children: _kPages,
            ),
          ),
        ));
  }
}
