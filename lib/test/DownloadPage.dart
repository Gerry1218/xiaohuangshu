import 'package:flutter/material.dart';



class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: DownloadPageStatefulWidget(),
    );
  }
}

class DownloadPageStatefulWidget extends StatefulWidget {
  const DownloadPageStatefulWidget({Key? key}) : super(key: key);

  @override
  State<DownloadPageStatefulWidget> createState() => _DownloadPageStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _DownloadPageStatefulWidgetState extends State<DownloadPageStatefulWidget> {
  double _counter = 0.0;
  int percent = 0;

  Future<void> _futureWork() {
    return Future.delayed(const Duration(seconds: 1), () =>
        setState(() {
          _counter = _counter + 0.1;
        })
    );
  }

  @override
  Widget build(BuildContext context) {

    if (_counter < 0.95) {
      _futureWork();
    }

    percent = (_counter * 100.0).round();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '$percent%',
              style: const TextStyle(fontSize: 20),
            ),
            LinearProgressIndicator(
              value: _counter,
              semanticsLabel: 'Linear progress indicator',
            ),
            CircularProgressIndicator(
              value: _counter,
              semanticsLabel: 'Circular progress indicator',
            ),
          ],
        ),
      ),
    );
  }
}
