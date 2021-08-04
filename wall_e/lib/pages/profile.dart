import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late var data;
  savePersonalInfo() async {
    var response = await Dio().post(
        'http://192.168.43.189:6969/profile?fullname=fullname&password=password&');
  }

  getPersonalInfo() async {
    var response = await Dio()
        .get('http://192.168.43.189:6969/profile?username=widget.username');
    return response.data;
  }

  @override
  void initState() {
    data = getPersonalInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: null,
            child: Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
          ],
        ),
      ),
    );
  }
}
