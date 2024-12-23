import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xhs/test/test_page1.dart';

import 'bottom_sheet_navigator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  BehaviorSubject behaviorSubject = BehaviorSubject();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

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
    behaviorSubject.sink.addStream(RangeStream(0, 4).interval(const Duration(seconds: 2)));
  }

  void println(Object value) {
    print('${DateTime.now()}: $value');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        debugPrint("onPopInvokedWithResult: $didPop $result");
      },
      child: Scaffold(
        body: Container(
          color: Colors.greenAccent,
          padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 20, color: Colors.red),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: GestureDetector(
                  onTap: () async {
                    var res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TestPage1()));
                    debugPrint("xxxx $res");
                  },
                  child: Text("Heelooo"),
                )
                    // buildTextButton(context),
                    ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.amberAccent,
                    width: 100,
                    height: 40,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: 100,
                    height: 70,
                    color: Colors.cyan,
                  ),
                ),
                SliverToBoxAdapter(
                  child: TextButton(
                      onPressed: () {
                        debugPrint("click ");
                        _focusNode.unfocus();
                      },
                      child: Text("按钮")),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyHeaderDelegate(
                    height: 48,
                    child: Container(
                      width: 200,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(labelText: '输入框'),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
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
                          decoration: BoxDecoration(color: Colors.white10),
                          // color: Colors.white10,
                          padding: EdgeInsets.all(8),
                          child: Text("Hello world"),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder(
                      stream: getTime(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        debugPrint(" $snapshot");
                        if (snapshot.hasData) {
                          return Text(" ${snapshot.data}");
                        }
                        return Text("err");
                      }),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.red,
                    height: 1400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildTextButton(BuildContext context) {
    return TextButton(
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
          style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.w500),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Stream<DateTime> getTime() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1), () {
        debugPrint("getTime 1s");
      });
      yield DateTime.now();
    }
  }
}

class MyRenderBox extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    throw UnimplementedError();
  }
}

class RenderMyRenderBox extends RenderBox with RenderObjectWithChildMixin {
  @override
  void performLayout() {
    // TODO: implement performLayout
    super.performLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
    super.paint(context, offset);
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  StickyHeaderDelegate({required this.height, required this.child});

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}
