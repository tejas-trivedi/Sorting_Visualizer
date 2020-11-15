import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorting_visualizer/algos/shell.dart';
import './algos/bubble.dart';
import './algos/insertion.dart';
import './algos/selection.dart';
import './algos/merge.dart';
import './algos/quick.dart';
import './algos/shell.dart';
import './algos/heap.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting_Visualizer',
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
  String _currentSortAlgo = 'merge';
  double _sampleSize = 400;
  bool isSorted = false;
  bool isSorting = false;
  int speed = 0;
  static int duration = 1600;
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
        if (_nums[j] < _nums[j + 1]) {    //>
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
      while (j >= 0 && temp > _nums[j]) {       // <
        _nums[j + 1] = _nums[j];
        //_nums[j] = _nums[j+1];
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
        if (_nums[i] < _nums[j]) {
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

    if (l < n && arr[l] < arr[largest]) largest = l;    // >

    if (r < n && arr[r] < arr[largest]) largest = r;    // >

    if (largest != i) {
      int temp = _nums[i];
      _nums[i] = _nums[largest];
      _nums[largest] = temp;
      heapify(arr, n, largest);
    }
    await Future.delayed(_getDuration());
  }

  func(int a, int b) {
    if (a > b) {      // <
      return -1;
    } else if (a < b) {       //>
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
      for (int j = 0; j < rightSize; j++)
        rightList[j] = _nums[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] >= rightList[j]) {
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

  _shellSort() async {
    for (int gap = _nums.length ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < _nums.length; i += 1) {
        int temp = _nums[i];
        int j;
        for (j = i; j >= gap && _nums[j - gap] > temp; j -= gap)
          _nums[j] = _nums[j - gap];
        _nums[j] = temp;
        await Future.delayed(_getDuration());
        _streamController.add(_nums);
      }
    }
  }

// END OF ALGORITHMS:)

  _reset() {
    isSorted = false;
    _nums = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _nums.add(Random().nextInt(500));
    }
    _streamController.add(_nums);
  }

  _setSortAlgo(String type) {
    setState(() {
      _currentSortAlgo = type;
    });
  }

  _checkAndResetIfSorted() async {
    if (isSorted) {
      _reset();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _changeSpeed() {
    if (speed >= 3) {
      speed = 0;
      duration = 1500;
    } else {
      speed++;
      duration = duration ~/ 2;
    }

    print(speed.toString() + " " + duration.toString());
    setState(() {});
  }

  String _getTitle() {
    switch (_currentSortAlgo) {
      case "bubble":
        return "Bubble Sort";
        break;
      case "heap":
        return "Heap Sort";
        break;
      case "selection":
        return "Selection Sort";
        break;
      case "insertion":
        return "Insertion Sort";
        break;
      case "quick":
        return "Quick Sort";
        break;
      case "merge":
        return "Merge Sort";
        break;
      case "shell":
        return "Shell Sort";
        break;
    }
  }

  _sort() async {
    setState(() {
      isSorting = true;
    });

    await _checkAndResetIfSorted();

    Stopwatch stopwatch = new Stopwatch()..start();

    switch (_currentSortAlgo) {
      case "bubble":
        await _bubbleSort();
        break;
      case "selection":
        await _selectionSort();
        break;
      case "quick":
        await _quickSort(0, _sampleSize.toInt() - 1);
        break;
      case "merge":
        await _mergeSort(0, _sampleSize.toInt() - 1);
        break;
      case "heap":
        await _heapSort();
        break;
      case "insertion":
        await _insertionSort();
        break;
      case "shell":
        await _shellSort();
        break;
    }

    stopwatch.stop();

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.",
        ),
      ),
    );
    setState(() {
      isSorting = false;
      isSorted = true;
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(_getTitle()),
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          PopupMenuButton<String>(
            initialValue: _currentSortAlgo,
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: 'bubble',
                  child: Text("Bubble Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
                PopupMenuItem(
                  value: 'selection',
                  child: Text("Selection Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
                PopupMenuItem(
                  value: 'insertion',
                  child: Text("Insertion Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
                PopupMenuItem(
                  value: 'merge',
                  child: Text("Merge Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
                PopupMenuItem(
                  value: 'quick',
                  child: Text("Quick Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
                PopupMenuItem(
                  value: 'heap',
                  child: Text("Heap Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
                PopupMenuItem(
                  value: 'shell',
                  child: Text("Shell Sort"),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15),
                ),
              ];
            },
            onSelected: (String value) {
              _reset();
              _setSortAlgo(value);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            children: <Widget>[
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Bubble Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          BubbleSort()));
                },
              ),
              Divider(height: 5.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Insertion Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          InsertionSort()));
                },
              ),
              Divider(height: 5.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Selection Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          SelectionSort()));
                },
              ),
              Divider(height: 5.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Merge Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          MergeSort()));
                },
              ),
              Divider(height: 5.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Quick Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          QuickSort()));
                },
              ),
              Divider(height: 5.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Shell Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          ShellSort()));
                },
              ),
              Divider(height: 5.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                title: Text('Heap Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HeapSort()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 0.0),
          child: StreamBuilder<Object>(
              initialData: _nums,
              stream: _streamController.stream,
              builder: (context, snapshot) {
                List<int> numbers = snapshot.data;
                int counter = 0;

                return Row(
                  children: numbers.map((int num) {
                    counter+=1;
                    return Container(
                      child: CustomPaint(
                        painter: BarPainter(
                            index: counter,
                            value: num,
                            width: MediaQuery.of(context).size.width /
                                _sampleSize),
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton(
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black87),
                    ),
                    onPressed: isSorting
                        ? null
                        : () {
                            _reset();
                            _setSortAlgo(_currentSortAlgo);
                          },
                    child: Text("RESET"))),
            Expanded(
                child: FlatButton(
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black87)),
                    onPressed: isSorting ? null : _sort,
                    child: Text("SORT"))),
            Expanded(
                child: FlatButton(
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black87)),
                    onPressed: isSorting ? null : _changeSpeed,
                    child: Text(
                      "${speed + 1}x",
                      style: TextStyle(fontSize: 16),
                    ))),
          ],
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Colors.lightBlue[50]; //Color(0xFFDEEDCF);
    } else if (this.value < 500 * .20) {
      paint.color = Colors.lightBlue[100];
    } else if (this.value < 500 * .30) {
      paint.color = Colors.lightBlue[200];
    } else if (this.value < 500 * .40) {
      paint.color = Colors.lightBlue[300];
    } else if (this.value < 500 * .50) {
      paint.color = Colors.lightBlue[400];
    } else if (this.value < 500 * .60) {
      paint.color = Colors.lightBlue[500];
    } else if (this.value < 500 * .70) {
      paint.color = Colors.lightBlue[600];
    } else if (this.value < 500 * .80) {
      paint.color = Colors.lightBlue[700];
    } else if (this.value < 500 * .90) {
      paint.color = Colors.lightBlue[800];
    } else {
      paint.color = Colors.lightBlue[900];
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 2),
        Offset(index * this.width, this.value.ceilToDouble()), paint);
    //canvas.drawLine(p1, p2, paint)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
