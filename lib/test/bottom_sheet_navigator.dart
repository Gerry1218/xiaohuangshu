import 'package:flutter/material.dart';
import 'package:xhs/test/second_page.dart';

import 'bottom_sheet_home_page.dart';

class BottomSheetNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        // Define the routes for the Navigator inside the Bottom Sheet
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) {
                return BottomSheetHomePage();
              },
            );
          case '/second':
            return MaterialPageRoute(
              builder: (context) {
                return SecondPage();
              },
            );
          default:
            return null;
        }
      },
    );
  }
}