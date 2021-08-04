import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/pages/mainPage.dart';

class ResetPassword extends StatefulWidget {
  late final String username;
  ResetPassword({required this.username});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _password = "";
  String _confirmPassword = "";
  String _status = "";

  Reset(String password, String confirmPassword) async {
    var response = await Dio().post(
        'http://192.168.43.189:6969/resetPassword?username=${widget.username}&password=${_password}');
    if (response.data['status'] == '') {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
    // print(widget.username);
    else {
      final snackBar = SnackBar(
        content: Text(
          '${response.data['status']}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.lock),
        ),
        labelText: 'Your New Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.length < 8) {
          return 'Password Must Be 8 Characters Minimum';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_password = value},
      onSaved: (value) => {_password = value!},
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.lock),
        ),
        labelText: 'Confirm Your New Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.length != _password.length) {
          return 'Password Not Similar To The One Entered Above';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_confirmPassword = value},
      onSaved: (value) => {_confirmPassword = value!},
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
                        'Reset Your Password',
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
                  _buildPassword(),
                  SizedBox(height: 10),
                  _buildConfirmPassword(),
                  SizedBox(height: 10),
                  Text('$_status'),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Reset(_password, _confirmPassword);
                      }
                    },
                    child: Text('Finish'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text(
                            'ctfvygbhnjkm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text('Snack'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
