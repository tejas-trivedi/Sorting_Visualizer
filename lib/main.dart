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

  _insertionSort() async {
    for (int i = 1; i < _nums.length; i++) {
      int temp = _nums[i];
      int j = i - 1;
      while (j >= 0 && temp < _nums[j]) {
        _nums[j + 1] = _nums[j];
        --j;
        await Future.delayed(_getDuration(), () {});

        _streamController.add(_nums);
      }
      _nums[j + 1] = temp;
      await Future.delayed(_getDuration(), () {});

      _streamController.add(_nums);
    }
  }

  _selectionSort() async {
    for (int i = 0; i < _nums.length; i++) {
      for (int j = i + 1; j < _nums.length; j++) {
        if (_nums[i] > _nums[j]) {
          int temp = _nums[j];
          _nums[j] = _nums[i];
          _nums[i] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_nums);
      }
    }
  }

_heapSort() async {
    for (int i = _nums.length ~/ 2; i >= 0; i--) {
      await heapify(_nums, _nums.length, i);
      _streamController.add(_nums);
    }
    for (int i = _nums.length - 1; i >= 0; i--) {
      int temp = _nums[0];
      _nums[0] = _nums[i];
      _nums[i] = temp;
      await heapify(_nums, i, 0);
      _streamController.add(_nums);
    }
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;

    if (r < n && arr[r] > arr[largest]) largest = r;

    if (largest != i) {
      int temp = _nums[i];
      _nums[i] = _nums[largest];
      _nums[largest] = temp;
      heapify(arr, n, largest);
    }
    await Future.delayed(_getDuration());
  }

  func(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  _quickSort(int leftIndex, int rightIndex) async {
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = _nums[p];
      _nums[p] = _nums[right];
      _nums[right] = temp;
      await Future.delayed(_getDuration(), () {});

      _streamController.add(_nums);

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (func(_nums[i], _nums[right]) <= 0) {
          var temp = _nums[i];
          _nums[i] = _nums[cursor];
          _nums[cursor] = temp;
          cursor++;

          await Future.delayed(_getDuration(), () {});

          _streamController.add(_nums);
        }
      }

      temp = _nums[right];
      _nums[right] = _nums[cursor];
      _nums[cursor] = temp;

      await Future.delayed(_getDuration(), () {});

      _streamController.add(_nums);

      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      await _quickSort(leftIndex, p - 1);

      await _quickSort(p + 1, rightIndex);
    }
  }


  _mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = new List(leftSize);
      List rightList = new List(rightSize);

      for (int i = 0; i < leftSize; i++) leftList[i] = _nums[leftIndex + i];
      for (int j = 0; j < rightSize; j++) rightList[j] = _nums[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          _nums[k] = leftList[i];
          i++;
        } else {
          _nums[k] = rightList[j];
          j++;
        }

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_nums);

        k++;
      }

      while (i < leftSize) {
        _nums[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_nums);
      }

      while (j < rightSize) {
        _nums[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_nums);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(_getDuration(), () {});

      _streamController.add(_nums);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }





}