import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class Item {
  RxInt id;
  RxString name;

  Item(int id, String name)
      : id = id.obs,
        name = name.obs;
}

class People {
  String? name;
  int? age;

  People(this.name, this.age);
}

class MyController extends GetxController {
  List<Item> items = <Item>[].obs;

  RxBool a = false.obs;

  var p = People("gerry", 18).obs;

  var peoples = [].obs;

  changeName() {
    String n = Random().nextInt(100).toString();
    p.value.name = n;
  }

  changeList() {
    String n = Random().nextInt(100).toString();
    peoples[Random().nextInt(peoples.length)].name = n;
    peoples.refresh();
  }

  testComplete(v) async {
    Completer c = Completer();
    Future.delayed(const Duration(seconds: 3), () {
      c.complete("v- $v ");
    });
    return c.future;
  }

  int val = 0;
  test() async* {
    Stream s = StreamController().stream;
    Timer.periodic(Duration(seconds: 1), (t){
      val++;

    });
    yield* s;
  }

  /// 异步流
  Stream<int> testAsync() async* {
    for (int i = 0; i < 100; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  Iterable<int> generator1() sync* {
    yield 1;
    yield* generator2(); // 转发 generator2 的值
    yield 4;
  }

  generator2() async* {
    yield 2;
    yield 3;
  }

  testSubscriber() {
    final subject = BehaviorSubject<int>.seeded(0);

    // 订阅 1
    subject.listen((value) {
      print('Subscriber 1 received: $value');
    });

    // 向 BehaviorSubject 添加新值
    subject.add(1); // 这将发出 1 给 Subscriber 1
    subject.add(2); // 这将发出 2 给 Subscriber 1

    // 订阅 2
    subject.listen((value) {
      print('Subscriber 2 received: $value');
    });

    // 向 BehaviorSubject 添加新值
    subject.add(3);

    subject.close();
  }


  @override
  void onInit() {
    a.toggle();

    super.onInit();
    items.add(Item(1, "index 1"));
    items.add(Item(2, "index 2"));
    items.add(Item(3, "index 3"));
    items.add(Item(4, "index 4"));
    items.add(Item(5, "index 5"));

    peoples.add(People("gerry", 18));
    peoples.add(People("tony", 28));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  updateItem(index, name) {
    items[index].name.value = name;
    debugPrint("updateItem: $index, $name");
  }

  addItem() {
    int idx = items.length + 1;
    String name = "index $idx";
    items.add(Item(idx, name));
  }
}
