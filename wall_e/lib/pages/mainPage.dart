import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/pages/login.dart';
import 'package:wall_e/routes/routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    trendingFuture = _getWalls();
    super.initState();
  }

  Widget _buildSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white54),
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      // controller: search,
                      decoration: InputDecoration(
                        hintText: 'search ...',
                        border: InputBorder.none,
                      ),
                      cursorHeight: 24,
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: null,
          child: Text('Search'),
        ),
      ],
    );
  }

  late Future trendingFuture;
  _getWalls() async {
    var respoonse = await Dio().get('http://192.168.43.189:6969/getWallpapers');
    var el = respoonse.data;
    List trending = [];
    for (var item in el) {
      trending.add('http://192.168.43.189:6969/' + item);
    }
    return (trending);
    // setState(() {
    //   src = 'http://192.168.43.189:6969/' + el;
    // });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                'App Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
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
              onTap: () {},
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: _getWalls,
                      child: Text('abstact'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('animals'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('city'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('entertainment'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('food & drinks'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('holiday'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('nature'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('people'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('sports'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('tech'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text('vehicles'),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: Dio().get('http://192.168.43.189:6969/getWallpapers'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var response = jsonDecode(snapshot.data.toString());
                  // print(response['files'].length);
                  var items = [];
                  for (var item in response['files']) {
                    items.add(
                      Image.network(
                        'http://192.168.43.189:6969/' + item,
                        filterQuality: FilterQuality.low,
                        height: 300,
                        width: 300,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 1000,
                    width: 1000,
                    child: _startPageImages(items),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

_startPageImages(items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (BuildContext ctx, int index) {
      return items[index];
    },
  );
}

_generateGridViewCount(children) {
  return GridView.count(
    crossAxisCount: 2,
    children: <Widget>[children],
  );
}
