import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/main_features/screens/home_page_screen.dart';
import 'package:wall_e/auth/register/blocs/blocs.dart';
import 'package:wall_e/auth/register/models/register_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final _fullnameController = TextEditingController();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _secretKeyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        'Register',
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
                  _buildFullname(_fullnameController),
                  SizedBox(height: 6),
                  _buildUsername(_usernameController),
                  SizedBox(height: 6),
                  _buildPassword(_passwordController),
                  SizedBox(height: 6),
                  _buildSecretKey(_secretKeyController),
                  SizedBox(height: 6),
                  Text(
                    'This Key Is Going To Be Used To Reset Your Password If Forgotten.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                  ),
                  SizedBox(height: 10),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(),
                          ),
                        );
                      }

                      if (state is RegisterFailure) {
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
                      if (state is RegisterProgress) {
                        return LinearProgressIndicator();
                      }

                      return OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final bloc = BlocProvider.of<RegisterBloc>(context);
                            final user = RegisterUserModel(
                              fullname: _fullnameController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              secretKey: _secretKeyController.text,
                            );
                            bloc.add(AttemptRegister(user: user));
                          }
                        },
                        child: Text('Register'),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have An Account?',
                        style: TextStyle(fontSize: 12),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login!',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
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

Widget _buildFullname(controller) {
  return TextFormField(
    controller: controller,
    keyboardAppearance: Brightness.dark,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(Icons.person),
      ),
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
  );
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

Widget _buildSecretKey(controller) {
  return TextFormField(
    controller: controller,
    keyboardAppearance: Brightness.dark,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(Icons.security),
      ),
      labelText: 'Secret Key',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    validator: (value) {
      if (value!.length != 6) {
        return 'Secret Key Must Be 6 Characters Only';
      } else {
        return null;
      }
    },
  );
}
