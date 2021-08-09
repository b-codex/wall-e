import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/pages/login.dart';
import 'package:wall_e/routes/routes.dart';
import 'package:wall_e/sharedPreference.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        title: Row(
          children: [
            Text('Wall-'),
            Text(
              'e',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'icon/appIcon.png',
                    width: 100,
                  ),
                  Text(
                    'Wall-e',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RouteManager.profile);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RouteManager.favorites,
                    arguments: {'username': username});
              },
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    var _prefs = sharedPreference();
                    _prefs.removeUsername();
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: FutureBuilder(
            future: Dio().get('http://10.0.2.2:6969/getWallpapers'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    _buildCategories(context),
                    // SizedBox(height: 5),
                    _startPageImages(snapshot, context),
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

Widget _buildCategories(context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'abstract'});
            },
            child: Text('abstact'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'animals'});
            },
            child: Text('animals'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'city'});
            },
            child: Text('city'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'cars'});
            },
            child: Text('cars'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'food'});
            },
            child: Text('food'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'nature'});
            },
            child: Text('nature'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'sports'});
            },
            child: Text('sports'),
          ),
          SizedBox(width: 7),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteManager.category,
                  arguments: {'category': 'phony'});
            },
            child: Text('phony'),
          ),
        ],
      ),
    ),
  );
}

Widget _startPageImages(snapshot, context) {
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
