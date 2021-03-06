import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstreamproject/models/Photo.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  StreamController<Photo> _streamController;
  List<Photo> list = [];

  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();

    _streamController.stream.listen((p) => setState(() => list.add(p)));

    load(_streamController);
  }

  load(StreamController<Photo> sc) async {
    String url = "https://jsonplaceholder.typicode.com/photos";
    var client = new http.Client();

    var req = new http.Request('get', Uri.parse(url));

    var streamedRes = await client.send(req);

    streamedRes.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Photo.fromJsonMap(map))
        .pipe(sc);
  }

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Streams"),
      ),
      body: Center(
        child: ListView.builder(
//          scrollDirection: Axis.horizontal,

          itemBuilder: (BuildContext context, int index) => _makeElement(index),
          itemCount: list.length,
        ),
      ),
    );
  }

  Widget _makeElement(int index) {
    if (index >= list.length) {
      return null;
    }

    return Container(
        padding: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.only(top: 200.0),
          child: Column(
            children: <Widget>[
              Image.network(list[index].url, width: 150.0, height: 150.0),
              Text(list[index].title),
            ],
          ),
        ));
  }
}