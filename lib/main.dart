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

  @override
  Widget build(BuildContext context) {
    final _media= MediaQuery.of(context).size;
    return Scaffold(
      body:
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: 150),
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
                    backgroundColor: Colors.black87,
                    size: Size(double.infinity, double.infinity),
                    waveAmplitude: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 65,
                        child: Image.asset('assets/logo.png')),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: _media.height-150,
              ),
              height: _media.height*0.81,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Animator(
                          tween: Tween<double>(
                              begin: 0.8,
                              end: 1.4
                          ),
                          curve: Curves.elasticOut,
                          cycles: 0,
                          builder: (anim) => Transform.scale(
                            scale: anim.value,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 60,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            counter(x),
                            counter(y),
                            SizedBox(
                              width: 5,
                            ),
                            Text("BPM", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      width: _media.width,
                      color: Colors.grey.shade200,
                      child: Align(
                        alignment: Alignment.center,
                          child: Text("GRAPH PLACEHOLDER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}

Widget counter(var num){
  return Container(
    child: Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(num.toString(), style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
      ),
    ),
  );
}