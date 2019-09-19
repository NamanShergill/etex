/// Demo of using the oscilloscope package
///
/// In this demo 2 displays are generated showing the outputs for Sine & Cosine
/// The scope displays will show the data sets  which will fill the yAxis and then the screen display will 'scroll'
import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Oscilloscope Display Example",
      home: Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  List<double> traceSine = List();
  double radians = 0.0;
  Timer _timer;
  bool check=true;
  var A=[];
  var c=0.0;


  /// method to generate a Test  Wave Pattern Sets
  /// this gives us a value between +1  & -1 for sine & cosine4

  _generateTrace(Timer t) {

    var a=0.0;
    for(int i=0;i<100;i++) {
      if (check) {
        a = A[i];
      }
      setState(() {
        traceSine.add(a);
      });

    }
  }

  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    for(int i=0;i<100;i++)
      {
        if(i<20||i>69)
          A.add(0.0);
        else if(i<25) {
          c-=0.025;
          A.add(c);
        }
        else if(i<30){
          c+=0.025;
          A.add(c);
        }
        else if(i<50){
          c+=0.05;
          A.add(c);
        }
        else if(i<70){
          c-=0.05;
          A.add(c);
        }
      }
    _timer = Timer.periodic(Duration(milliseconds: 1000), _generateTrace);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create A Scope Display for Sine
    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.orange,
      padding: 20.0,
      backgroundColor: Colors.black,
      traceColor: Colors.green,
      yAxisMax: 1.0,
      yAxisMin: -1.0,
      dataSet: traceSine,
    );

    // Create A Scope Display for Cosine
    // Generate the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text("OscilloScope Demo"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: scopeOne),
        ],
      ),
    );
  }
}