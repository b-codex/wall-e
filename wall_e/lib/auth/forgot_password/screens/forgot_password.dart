import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/auth/forgot_password/blocs/blocs.dart';
import 'package:wall_e/auth/forgot_password/models/fp_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _secretKeyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
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
                  _buildUsername(_usernameController),
                  SizedBox(height: 10),
                  _buildPassword(_passwordController),
                  SizedBox(height: 10),
                  _buildSecretKey(_secretKeyController),
                  SizedBox(height: 10),
                  BlocConsumer<FP_Bloc, FP_State>(
                    listener: (context, state) {
                      print(state);
                      if (state is ResetSuccess) {
                        print("Password Reset Success");
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => LoginScreen(),
                        //   ),
                        // );
                      }

                      if (state is ResetFailure) {
                        final message = state.message;
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
                      print(state);
                      if (state is ResetProgress) {
                        return LinearProgressIndicator();
                      }
                      return OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final bloc = BlocProvider.of<FP_Bloc>(context);
                            final fp_model = FP_Model(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              secretKey: _secretKeyController.text,
                            );
                            bloc.add(AttemptReset(fp_model: fp_model));
                          }
                        },
                        child: Text('Reset Password'),
                      );
                    },
                  ),
                  SizedBox(height: 10),
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
