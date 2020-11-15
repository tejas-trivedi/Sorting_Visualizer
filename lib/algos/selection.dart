import 'package:flutter/material.dart';
import 'package:sorting_visualizer/algos/bubble.dart';
import './insertion.dart';
import './merge.dart';


class SelectionSort extends StatefulWidget {
  @override
  _TextState createState() => _TextState();
}

class _TextState extends State<SelectionSort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 10.0,
        title: Text("Selection Sort"),
      ),
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
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black54,
                width: 10,
              ),
            ),
            child: Image.asset("assets/images/selection.png"),
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BubbleSort()));
                },
              ),
              Divider(height: 0.0),
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
                title: Text('Merge Sort', style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          MergeSort()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}