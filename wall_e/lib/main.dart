import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Comfortaa',
      ),
      initialRoute: RouteManager.loginPage,
      // initialRoute: RouteManager.mainPage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
