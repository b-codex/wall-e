import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/pages/mainPage.dart';
import 'package:wall_e/routes/routes.dart';
import 'package:wall_e/sharedPreference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _prefs = sharedPreference();

  String _username = "";
  String _password = "";

  Widget _buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.alternate_email),
        ),
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

  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.lock),
        ),
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
      onChanged: (value) => {_password = value},
      onSaved: (value) => {_password = value!},
    );
  }

  _login(String username, String password) async {
    var response = await Dio().get(
        'http://10.0.2.2:6969/login?username=$username&password=$password');
    if (response.data['status'] == '') {
      _prefs.saveUsername('$username');
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Login Failed! Check Credentials & Try Again!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    final snackBar = SnackBar(
      content: Text(
        'Logging In',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    );
    var _prefs = sharedPreference();
    _prefs.getUsername().then(
          (value) => {
            if (value != null)
              {
                ScaffoldMessenger.of(context).showSnackBar(snackBar),
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        'Login',
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
                  _buildUsername(),
                  SizedBox(height: 10),
                  _buildPassword(),
                  SizedBox(height: 6),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _login(_username, _password);
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have An Account?',
                        style: TextStyle(fontSize: 12, fontFamily: 'Comfortaa'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteManager.registerPage);
                        },
                        child: Text(
                          'Register Now!',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteManager.forgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
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
