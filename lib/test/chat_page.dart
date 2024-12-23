import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FocusNode inputFocusNode = FocusNode();

  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("ChatPage")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            }),
          ),
          _buildTool()
        ],
      ),
    );
  }

  _buildTool() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.pink,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, context.mediaQueryViewInsets.bottom),
                    child: Text("Send ok"),
                  )
              );
            },
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.orange.withOpacity(0.2),
                filled: true
              ),
              focusNode: inputFocusNode,
              readOnly: readOnly,
              showCursor: true,
            ),
          ),
        ),
        GestureDetector(
          child: const Icon(Icons.add, size: 30),
          onTap: () {

          },
        ),
      ],
    );
  }
}
