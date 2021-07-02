import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayısal Loto Tahmin Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Sayısal Loto Tahmin Uygulaması'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int randomNums0 = 0;
  int randomNums1 = 0;
  int randomNums2 = 0;
  int randomNums3 = 0;
  int randomNums4 = 0;
  int randomNums5 = 0;
  String ipAddress = 'http://192.168.1.25:8080/';

  Future<List<int>> GetRandomNumbers() async {
    var resp = json.decode(await http.read(Uri.parse(ipAddress)));
    return new List<int>.from(resp);
  }

  Future<void> setNums() async {
    var nums = await GetRandomNumbers();
    setState(() {
      randomNums0 = nums[0];
      randomNums1 = nums[1];
      randomNums2 = nums[2];
      randomNums3 = nums[3];
      randomNums4 = nums[4];
      randomNums5 = nums[5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: ipAddress,
                    onChanged: (text) {
                      ipAddress = text;
                    },
                  ),
                  padding: EdgeInsets.only(bottom: 50.0)),
              Text(
                'SAYILAR',
              ),
              Text(
                '$randomNums0',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$randomNums1',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$randomNums2',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$randomNums3',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$randomNums4',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$randomNums5',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Center(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120.0,
                width: 120.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 35.0, top: 50.0),
                  child: FloatingActionButton(
                    onPressed: setNums,
                    tooltip: 'Yeni sayı çek',
                    child: Icon(Icons.refresh),
                  ),
                ),
              )),
        ));
  }
}
