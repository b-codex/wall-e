import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/pages/resetPassword.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fullname = "";
  String _username = "";
  String answer1 = "";
  String answer2 = "";
  String answer3 = "";

  forgotPassword(String fullname, String username, String answer1,
      String answer2, String answer3) async {
    var response = await Dio().get(
        'http://10.0.2.2:6969/forgotPassword?fullname=${fullname}&username=${username}&answer1=$answer1&answer2=$answer2&answer3=$answer3');
    if (response.data['status'] == '') {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassword(
            username: username,
          ),
        ),
      );
    } else {
      String status = response.data['status'];
      final snackBar = SnackBar(
        content: Text(
          '$status',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildFullname() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Fullname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fullname Is Required';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_fullname = value},
      onSaved: (value) => {_fullname = value!},
    );
  }

  Widget _buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Username Must Be 5 Characters Minimum';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_username = value},
      onSaved: (value) => {_username = value!},
    );
  }

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

  // @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIOverlays([]);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wall-e'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        'Enter Your Info',
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
                  SizedBox(height: 50),
                  _buildFullname(),
                  SizedBox(height: 10),
                  _buildUsername(),
                  SizedBox(height: 10),
                  _buildQuestion1(),
                  SizedBox(height: 10),
                  _buildQuestion2(),
                  SizedBox(height: 10),
                  _buildQuestion3(),
                  SizedBox(height: 6),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        forgotPassword(
                            _fullname, _username, answer1, answer2, answer3);
                      }
                    },
                    child: Text('Next'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
