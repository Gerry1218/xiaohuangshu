import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetHomePage extends StatelessWidget {
  const BottomSheetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet Home Page')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Go to Second Page'),
            onTap: () {
              Navigator.pushNamed(context, '/second');
            },
          ),
          ListTile(
            title: const Text('Close Bottom Sheet'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        ],
      ),
    );
  }
}
