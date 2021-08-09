import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/routes/routes.dart';
import 'package:wall_e/sharedPreference.dart';

class Category extends StatefulWidget {
  final String category;
  Category({required this.category});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIOverlays([]);
  //   trendingFuture = _getWalls();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    String? username;
    var _prefs = sharedPreference();
    _prefs.getUsername().then((value) => username = value);

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Wall-e'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: FutureBuilder(
            future: Dio().get(
                'http://10.0.2.2:6969/category?category=${widget.category}'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    _buildImages(snapshot, context),
                  ],
                );
              } else {
                return LinearProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildImages(snapshot, context) {
  snapshot = jsonDecode(snapshot.data.toString());
  var files = snapshot['files'];

  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.count(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: files.map<Widget>(
            (file) {
              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteManager.image,
                        arguments: {'url': 'http://10.0.2.2:6969/' + file});
                  },
                  child: Hero(
                    tag: 'http://10.0.2.2:6969/' + file,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://10.0.2.2:6969/' + file,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList() as List<Widget>,
        ),
      ),
    ],
  );
}
