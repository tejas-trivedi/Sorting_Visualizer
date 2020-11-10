import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<int> _nums = [];
  StreamController<List<int>> _streamController = StreamController();

  double _sampleSize = 350;
  bool isSorted = false;
  bool isSorting = false;
  int speed = 0;
  static int duration = 1500;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Duration _getDuration() {
    return Duration(microseconds: duration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sampleSize = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < _sampleSize; ++i) {
      _nums.add(Random().nextInt(500));
    }
    setState(() {});
  }


  // ALGORITHMS START FROM HERE:)

  _bubbleSort() async {
    for (int i = 0; i < _nums.length; ++i) {
      for (int j = 0; j < _nums.length - i - 1; ++j) {
        if (_nums[j] > _nums[j + 1]) {
          int temp = _nums[j];
          _nums[j] = _nums[j + 1];
          _nums[j + 1] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_nums);
      }
    }
  }


}