import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/main_features/screens/home_page_screen.dart';
import 'package:wall_e/login/blocs/blocs.dart';
import 'package:wall_e/login/models/login_model.dart';
import 'package:wall_e/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
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
                  _buildUsername(_usernameController),
                  SizedBox(height: 10),
                  _buildPassword(_passwordController),
                  SizedBox(height: 6),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoggedIn) {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(),
                          ),
                        );
                        print("Successful Login");
                      }
                      if (state is LoginFailure) {
                        final String message = state.message;
                        final snackBar = SnackBar(
                          content: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginProgress) {
                        return LinearProgressIndicator();
                      }

                      return OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final loginBloc =
                                BlocProvider.of<LoginBloc>(context);

                            final user = LoginUserModel(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            );
                            loginBloc.add(AttemptLogin(user: user));
                          }
                        },
                        child: Text('Login'),
                      );
                    },
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
                          style: TextStyle(fontWeight: FontWeight.w400),
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

Widget _buildUsername(controller) {
  return TextFormField(
    controller: controller,
    keyboardAppearance: Brightness.dark,
    keyboardType: TextInputType.name,
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
  );
}

Widget _buildPassword(controller) {
  return TextFormField(
    controller: controller,
    keyboardAppearance: Brightness.dark,
    keyboardType: TextInputType.visiblePassword,
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
  );
}
