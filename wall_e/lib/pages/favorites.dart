import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/routes/routes.dart';

class Favorites extends StatefulWidget {
  final String username;

  Favorites({required this.username});

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // late var username = "";
  // @override
  // void initState() {
  //   super.initState();
  //   var _prefs = sharedPreference();
  //   _prefs.getUsername().then((value) => {username = (value)});
  //   print(username);
  // }

  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wall-e'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: FutureBuilder(
            future: Dio().get(
                'http://10.0.2.2:6969/getFavorite?username=${widget.username}'),
            builder: (context, snapshot) {
              // print(snapshot.data);
              if (snapshot.hasData) {
                return Column(
                  children: [
                    // SizedBox(height: 5),
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
                    Navigator.of(context).pushNamed(RouteManager.imageFav,
                        arguments: {'url': file});
                  },
                  child: Hero(
                    tag: file,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.network(file, fit: BoxFit.fill,),
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
