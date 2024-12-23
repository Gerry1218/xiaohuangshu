import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'getx_controller.dart';

class GetxPage extends StatefulWidget {
  const GetxPage({super.key});

  @override
  State<GetxPage> createState() => _GetxPageState();
}

class _GetxPageState extends State<GetxPage> {
  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Getx"),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              color: Colors.green,
              child: TextButton(
                  onPressed: () async {
                    // controller.addItem();
                    // controller.changeName();
                    // controller.changeList();
                    // Stream s = controller.testAsync();
                    // await for (var i in s) {
                    //   debugPrint("Stream data: $i ");
                    // }

                    controller.testSubscriber();
                  },
                  child: const Text("切换数据")),
            ),
            Obx((){
              return Wrap( children: [
                ...controller.peoples.map((item){
                  return Container(
                    color: Colors.pink,
                    margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: Text( "User: ${item.name} - ${item.age}", style: TextStyle(fontSize: 16),),
                  );
                })
              ]);
            }),
            Obx(() {
              return Container(
                height: 30,
                width: 80,
                color: Colors.orange,
                child: Text(
                  controller.p.value.name ?? "",
                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                ),
              );
            }),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
                      child: InkWell(
                        onTap: () {
                          controller.updateItem(index, "update ${Random().nextInt(100)}");
                        },
                        child: Obx(() => Row(
                              children: [
                                if (controller.items[index].id.value % 2 == 0)
                                  Text(
                                    "${controller.items[index].id.value}",
                                    style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.w700),
                                  ),
                                Text(
                                  controller.items[index].name.value,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                                )
                              ],
                            )),
                      ),
                    )
                        // )
                        ;
                  })),
            ),
          ],
        ));
  }
}
