import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:wave/config.dart';
import 'dart:async';
import 'dart:math';
import 'package:wave/wave.dart';
import 'package:animator/animator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Placeholder',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Prototype'),
    );
  }
}

var x=6;
var y=2;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double> traceSine = List();
  double radians = 0.0;
  Timer _timer;
  bool check=true;
  var A=[0.0,0.0,0.0,0.05,0.1,0.15,0.1,0.05,0.0,0.0,0.0,0.0,0.0,-0.025,0.0,0.1,0.2,0.3,0.4,0.4,0.3,0.2,0.1,0.0,-0.1,-0.05,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
  var c=0;
  var rng = new Random();
  var s=67;
  var counter=0;

  _generateTrace(Timer t) {
    counter++;
    if(counter==33){
      counter=0;
      s=63+rng.nextInt(12);
    }
    var a=0.0;
    a = A[c];
    c++;
    setState(() {
      if(c==A.length)                             //code for changing bpm
      traceSine.add(a);
    });
    if(c>=A.length)
      c=0;

  }

  @override
  initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 30), _generateTrace);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _media= MediaQuery.of(context).size;
    Oscilloscope scopeOne = Oscilloscope(
      padding: 20.0,
      backgroundColor: Colors.grey.shade50,
      traceColor: Colors.black,
      yAxisMax: 1.0,
      yAxisMin: -1.0,
      dataSet: traceSine,
    );

    return Scaffold(
        body:
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: 130),
              height: _media.height*0.19,
              child: Stack(
                children: <Widget>[
                  WaveWidget(
                    config: CustomConfig(
                      colors: [
                        Colors.white70,
                        Colors.white54,
                        Colors.white30,
                        Colors.grey.shade50,
                      ],
                      durations: [32000, 21000, 18000, 5000],
                      heightPercentages: [0.8, 0.87, 0.95, 1.0],
                    ),
                    backgroundColor: Colors.black26,
                    size: Size(double.infinity, double.infinity),
                    waveAmplitude: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        constraints: BoxConstraints(minHeight: 50),
                        height: _media.height*0.08,
                        child: Image.asset('assets/logo.png')),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: _media.height-130),
              height: _media.height*0.81,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  space(_media),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: _media.height*0.35,
                          width: _media.width*0.9,
                          color: Colors.grey.shade200,
                          child: Align(
                              alignment: Alignment.center,
                              child: scopeOne
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child:  Container(
                          height: _media.height*0.35,
                          child: Animator(
                            duration: Duration(milliseconds: 800),
                            tween: Tween<double>(
                                begin: 1,
                                end: 1.4
                            ),
                            curve: Curves.elasticOut,
                            cycles: 0,
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: _media.height*0.08,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  space(_media),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(s.toString(), style: TextStyle(fontSize: _media.height*0.05, fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 10,
                      ),
                      Text("BPM", style: TextStyle(fontSize: _media.height*0.05, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  space(_media),
                ],
              ),
            ),
          ],
        )
    );
  }
}

Widget counter(var num, final _media){
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Text(num.toString(), style: TextStyle(fontSize: _media.height*0.05, fontWeight: FontWeight.bold),),
    ),
  );
}

Widget space(final _media){
  return
    SizedBox(
      height: _media.height*0.05,
    );
}
