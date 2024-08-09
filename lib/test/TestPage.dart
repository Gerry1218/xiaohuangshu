import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
      child:Row(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
          Column(
            children: [
              Container(
                color: Colors.amberAccent,
                width: 100,
                height: 40,
              ),
              Container(
                width: 100,
                height: 70,
                color: Colors.cyan,
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
