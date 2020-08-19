import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new StopWatchState();
  }
}

class StopWatchState extends State<MyApp> {
  static const duration = const Duration(seconds: 1);

  bool _active = false;
  int secondsPassed = 0;
  Timer timer;

  void addSeconds() {
    if (_active) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        addSeconds();
      });

    int seconds = secondsPassed % 60;
    int mins = secondsPassed % (60 * 60) ~/ 60;
    int hrs = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'StopWatch',
      theme: ThemeData(
        primaryColor: Colors.indigo[900],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Stopwatch',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  customTile('HRS', hrs.toString().padLeft(2, '0')),
                  customTile('MINS', mins.toString().padLeft(2, '0')),
                  customTile('SECS', seconds.toString().padLeft(2, '0')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          _active = false;
                          secondsPassed = 0;
                        });
                      },
                      shape: CircleBorder(),
                      elevation: 6.0,
                      padding: const EdgeInsets.all(16.0),
                      fillColor: Colors.indigo[900],
                      child: Icon(
                        Icons.refresh,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          _active = !_active;
                        });
                      },
                      shape: CircleBorder(),
                      elevation: 6.0,
                      padding: const EdgeInsets.all(16.0),
                      fillColor: Colors.indigo[900],
                      child: Icon(
                        (_active ? Icons.pause : Icons.play_arrow),
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTile(String label, String val) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$val',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$label',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
