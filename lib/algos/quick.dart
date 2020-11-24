import 'package:flutter/material.dart';
import 'package:sorting_visualizer/algos/bubble.dart';
import './insertion.dart';
import './merge.dart';
import './selection.dart';
import './shell.dart';
import './heap.dart';

class QuickSort extends StatefulWidget {
  @override
  _TextState createState() => _TextState();
}

class _TextState extends State<QuickSort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 10.0,
        title: Text("Quick Sort",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        //child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "                                     Pseudocode",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.cyan[500],
                width: 10,
              ),
            ),
            child: Image.asset("assets/images/quick.png"),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            children: <Widget>[
              SizedBox(height: 15.0),
              Text("PSEUDOCODES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.cyan[700])),
              SizedBox(height: 50.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.assessment, color: Colors.cyan[700]),
                title: Text('Bubble Sort',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[400],
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BubbleSort()));
                },
              ),
              Divider(height: 0.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.assessment, color: Colors.cyan[700]),
                title: Text('Insertion Sort',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[400],
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => InsertionSort()));
                },
              ),
              Divider(height: 0.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.assessment, color: Colors.cyan[700]),
                title: Text('Merge Sort',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[400],
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MergeSort()));
                },
              ),
              Divider(height: 0.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.assessment, color: Colors.cyan[700]),
                title: Text('Selection Sort',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[400],
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SelectionSort()));
                },
              ),
              Divider(height: 0.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.assessment, color: Colors.cyan[700]),
                title: Text('Shell Sort',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[400],
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ShellSort()));
                },
              ),
              Divider(height: 0.0),
              ListTile(
                selected: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.assessment, color: Colors.cyan[700]),
                title: Text('Heap Sort',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[400],
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HeapSort()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
