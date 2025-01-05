import 'package:flutter/material.dart';
import 'package:xhs/constants/environment.dart';
import 'package:xhs/pages/index_page.dart';
import 'package:xhs/pages/home/home.dart';
import 'package:xhs/test/chat_page.dart';
import 'package:xhs/test/download_page.dart';
import 'package:xhs/test/expanded_page.dart';
import 'package:xhs/test/flashy_tabBar_page.dart';
import 'package:xhs/test/getx/getx_page.dart';
import 'package:xhs/test/google_navBar_page.dart';
import 'package:xhs/test/gridview_paging.dart';
import 'package:xhs/test/motion_tabBar_page.dart';
import 'package:xhs/test/my_nested_scrollView.dart';
import 'package:xhs/test/scroll_tab_page.dart';
import 'package:xhs/test/test_bloc.dart';
import 'package:xhs/test/test_page.dart';
import 'package:xhs/test/test_page1.dart';
import 'package:xhs/test/test_refresh_page.dart';

void main() async {
  debugPrint("Current Env: ${Environment.env}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // 去除TabBar底部线条
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ElevatedButton(
                    onPressed: () {
                      toHomePage();
                    },
                    child: Text("HomePage")),
                ElevatedButton(
                    onPressed: () {
                      toHome();
                    },
                    child: Text("Home")),
                ElevatedButton(
                    onPressed: () {
                      toTestPage();
                    },
                    child: Text("TestPage")),
                ElevatedButton(
                    onPressed: () {
                      toRefreshPage();
                    },
                    child: Text("RefreshPage")),
                ElevatedButton(
                    onPressed: () {
                      toScrollTabPage();
                    },
                    child: Text("ScrollTabPage")),
                ElevatedButton(
                    onPressed: () {
                      toExpandedPage();
                    },
                    child: Text("ExpandedPage")),
                ElevatedButton(
                    onPressed: () {
                      toSwiperPage();
                    },
                    child: Text("SwipPage-TestPage1")),
                ElevatedButton(
                    onPressed: () {
                      toNestedScrollPage();
                    },
                    child: Text("Nested Scroll Page")),
                ElevatedButton(
                    onPressed: () {
                      toDownloadPage();
                    },
                    child: Text("Download Page")),
                ElevatedButton(
                    onPressed: () {
                      toPage(const TestBloc());
                    },
                    child: Text("Test Bloc Page")),
                ElevatedButton(
                    onPressed: () {
                      toPage(const GetxPage());
                    },
                    child: Text("getx Page")),
                ElevatedButton(
                    onPressed: () {
                      toPage(const GridviewPaging());
                    },
                    child: Text("GridviewPaging")),
                ElevatedButton(
                    onPressed: () {
                      // toPage(const ChatPage());
                      test();
                      debugPrint("xxxx");
                      roomId = 0;
                      Future.delayed(Duration(seconds: 1), (){
                        roomId = 10;
                      });
                    },
                    child: Text("ChatPage")),
                ElevatedButton(
                    onPressed: () {
                      toPage(const MotionTabbarPage());
                    },
                    child: Text("MotionTabbarPage")),
                ElevatedButton(
                    onPressed: () {
                      toPage(const GoogleNavbarPage());
                    },
                    child: Text("GoogleNavbarPage")),
                ElevatedButton(
                    onPressed: () {
                      toPage(const FlashyTabbarPage());
                    },
                    child: Text("FlashyTabbarPage"))
              ],
            )
            ,

          ],
        ),
      ),
    );
  }

  int roomId = 10;
  test() async {
    debugPrint(" $roomId");
  }

  toRefreshPage() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => TestRefreshPage(),
        ));
  }

  toHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => HomePage(),
        ));
  }

  toHome() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Home(),
        ));
  }

  toTestPage() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const TestPage(),
        ));
  }

  toScrollTabPage() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ScrollTabPage(),
        ));
  }

  toExpandedPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext content) => const ExpandedPage()));
  }

  toSwiperPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext content) => const TestPage1()));
  }

  toNestedScrollPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext content) => const MyNestedScrollView()));
  }

  toDownloadPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext content) => const DownloadPage()));
  }

  toPage( page ) {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext content) => page));
  }

}
