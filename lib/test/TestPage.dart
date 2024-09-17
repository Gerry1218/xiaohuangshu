import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'bottom_sheet_navigator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  BehaviorSubject behaviorSubject = BehaviorSubject();

  @override
  void initState() {
    super.initState();

    println("behaviorSubject: $behaviorSubject");

    // the first subscription
    behaviorSubject.stream.listen((event) {
      println('First subscription: $event');
    });

    // the second subscription subsribes the above stream after 7 seconds
    Future.delayed(const Duration(seconds: 7), () {
      println('Create second subscription');
      behaviorSubject.stream.listen((event) {
        println('Second subscription: $event');
      });
    });

    // Push events every 2 seconds
    behaviorSubject.sink
        .addStream(RangeStream(0, 4).interval(const Duration(seconds: 2)));
  }

  void println(Object value) {
    print('${DateTime.now()}: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
      child: Row(
        children: [
          // Container(
          //   width: 100,
          //   height: 100,
          //   color: Colors.blue,
          // ),
          Column(
            children: [
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetNavigator();
                      },
                    );
                  },
                  child: const Text(
                    "点击事件",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                color: Colors.amberAccent,
                width: 100,
                height: 40,
              ),
              Container(
                width: 100,
                height: 70,
                color: Colors.cyan,
              ),
              Container(
                // color: Colors.amber,
                // margin: EdgeInsets.symmetric(horizontal: 50),
                child: ClipRRect(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white10
                      ),
                      // color: Colors.white10,
                      padding: EdgeInsets.all(8),
                      child: Text("Hello world"),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
