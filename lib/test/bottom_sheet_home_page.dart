import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Sheet Home Page')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Go to Second Page'),
            onTap: () {
              Navigator.pushNamed(context, '/second');
            },
          ),
          ListTile(
            title: Text('Close Bottom Sheet'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        ],
      ),
    );
  }
}
