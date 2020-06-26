import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstreamproject/screens/Photo_List.dart';


import 'models/Photo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        accentColor: Colors.amberAccent,
        canvasColor: Colors.white,
      ),
      home: PhotoList(),
    );
  }
}




