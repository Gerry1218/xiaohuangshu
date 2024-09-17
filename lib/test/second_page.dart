import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('This is the second page.'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}