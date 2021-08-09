import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/sharedPreference.dart';

import 'mainPage.dart';

class FinishRegister extends StatefulWidget {
  late final String fullname;
  late final String username;
  late final String password;

  FinishRegister(
      {required this.fullname, required this.username, required this.password});

  @override
  _FinishRegisterState createState() => _FinishRegisterState();
}

class _FinishRegisterState extends State<FinishRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _prefs = sharedPreference();

  String answer1 = "";
  String answer2 = "";
  String answer3 = "";

  Widget _buildQuestion1() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'What Is Your Nickname?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This Field Is Required';
        } else {
          return null;
        }
      },
      onChanged: (value) => {answer1 = value},
      onSaved: (value) => {answer1 = value!},
    );
  }

  Widget _buildQuestion2() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'What Is Your Favorite Place To Go?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This Field Is Required';
        } else {
          return null;
        }
      },
      onChanged: (value) => {answer2 = value},
      onSaved: (value) => {answer2 = value!},
    );
  }

  Widget _buildQuestion3() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Where Were You Born?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This Field Is Required';
        } else {
          return null;
        }
      },
      onChanged: (value) => {answer3 = value},
      onSaved: (value) => {answer3 = value!},
    );
  }

  Register(String answer1, String answer2, String answer3) async {
    widget.fullname.replaceAll(' ', '+');
    answer1.replaceAll(' ', '+');
    answer2.replaceAll(' ', '+');
    answer3.replaceAll(' ', '+');
    var response = await Dio().post(
        'http://10.0.2.2:6969/register?fullname=${widget.fullname}&username=${widget.username}&password=${widget.password}&answer1=$answer1&answer2=$answer2&answer3=$answer3');
    if (response.data['status'] == '') {
      _prefs.saveUsername('${widget.username}');
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Wall-e'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      'Finish Registration',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'The Questions Below Will Help You In Resetting Your Password',
                  style: TextStyle(
                    color: Colors.white38,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildQuestion1(),
                      SizedBox(height: 10),
                      _buildQuestion2(),
                      SizedBox(height: 10),
                      _buildQuestion3(),
                      SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Register(answer1, answer2, answer3);
                          }
                        },
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
