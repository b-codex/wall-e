import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wall_e/sharedPreference.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _prefs = sharedPreference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "N/A";
  String fullname = "N/A";
  String password = "";

  savePersonalInfo(String fullname, String password) async {
    var response = await Dio().post(
        'http://10.0.2.2:6969/profile?fullname=$fullname&username=$username&password=$password');
    if (response.data['status'] == '') {
      final snackBar = SnackBar(
        content: Text(
          'Saved!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Operation Failed!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future getPersonalInfo(String username) async {
    await _prefs.getUsername().then((value) => {username = value});
    await Future.delayed(Duration(seconds: 2));
    // print("Username: " + username);
    var response =
        await Dio().get('http://10.0.2.2:6969/profile?username=$username');
    // print(response.data);
    fullname = response.data['fullname'];
    password = response.data['password'];
    var user = {
      'fullname': fullname,
      'username': username,
      'password': password
    };
    return user;
  }

  Widget _buildFullname(snapshot) {
    return TextFormField(
      initialValue: snapshot.data['fullname'],
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'Fullname',
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
      onChanged: (value) {
        fullname = value;
      },
      onSaved: (value) => {fullname = value!},
    );
  }

  Widget _buildUsername(snapshot) {
    return TextFormField(
      initialValue: snapshot.data['username'],
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.alternate_email),
          labelText: 'Username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabled: false),
      enableInteractiveSelection: false,
    );
  }

  Widget _buildPassword(snapshot) {
    return TextFormField(
      initialValue: snapshot.data['password'],
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Password',
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
      onChanged: (value) {
        password = value;
      },
      onSaved: (value) => {password = value!},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                savePersonalInfo(fullname, password);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getPersonalInfo(username),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.all(22),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildFullname(snapshot),
                      SizedBox(height: 15),
                      _buildUsername(snapshot),
                      SizedBox(height: 15),
                      _buildPassword(snapshot),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return LinearProgressIndicator(
              value: null,
            );
          }
        },
      ),
    );
  }
}
