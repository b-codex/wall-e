import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/auth/login/blocs/blocs.dart';
import 'package:wall_e/auth/login/screens/login_screen.dart';
import 'package:wall_e/profile/blocs/blocs.dart';
import 'package:wall_e/sharedPreference.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

    TextEditingController fullname_controller = TextEditingController();
    TextEditingController username_controller = TextEditingController();
    TextEditingController password_controller = TextEditingController();
    TextEditingController secret_key_controller = TextEditingController();

    final bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SavedProfileState) {
          final snackBar = SnackBar(
            content: Text(
              'Saved',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          bloc.add(LoadProfileEvent());
        }

        if (state is FailedToSaveProfileState) {
          final snackBar = SnackBar(
            content: Text(
              'Failed To Save',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (ctx, state) {
        if (state is IdleProfileState) {
          bloc.add(LoadProfileEvent());
        }

        if (state is ProfileFailedToLoadState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Text(
                'API Error',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 21,
                ),
              ),
            ),
          );
        }

        if (state is ProfileLoadedState) {
          fullname_controller.text = state.fullname;
          username_controller.text = state.username;
          password_controller.text = state.password;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final bloc = BlocProvider.of<ProfileBloc>(context);
                      bloc.add(SaveProfileEvent(
                        fullname: fullname_controller.text,
                        username: username_controller.text,
                        password: password_controller.text,
                      ));
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/profile_picture.png',
                        width: 180,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: TextFormField(
                        controller: fullname_controller,
                        // initialValue: state.fullname,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Fullname",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This Field Is Required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: TextFormField(
                        controller: username_controller,
                        // initialValue: state.username,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This Field Is Required";
                          }
                          if (value.length < 5) {
                            return "Username Length Too Short";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return BlocConsumer<ProfileBloc, ProfileState>(
                                listener: (context, state) {
                                  if (state is PasswordChangedState) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Password Changed',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    );
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    bloc.add(LoadProfileEvent());
                                  }

                                  if (state is PasswordFailedToChangeState) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Password Failed To Change',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    );
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    bloc.add(LoadProfileEvent());
                                  }
                                },
                                builder: (ctx, state) {
                                  return Form(
                                    key: _passwordFormKey,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: .7,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(7),
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: password_controller,
                                              // initialValue: state.password,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.person),
                                                labelText: "Password",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "This Field Is Required";
                                                }
                                                if (value.length < 8) {
                                                  return "Password Length Too Short";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(7),
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: secret_key_controller,
                                              // initialValue: state.password,
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    Icon(Icons.security),
                                                labelText: "Secret Key",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "This Field Is Required";
                                                }
                                                if (value.length < 6 ||
                                                    value.length > 6) {
                                                  return "Secret Key Length Must Be Equal To 6";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                if (_passwordFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  bloc.add(
                                                    ChangePassword(
                                                      username:
                                                          username_controller
                                                              .text,
                                                      password:
                                                          password_controller
                                                              .text,
                                                      secret_key:
                                                          secret_key_controller
                                                              .text,
                                                    ),
                                                  );
                                                }
                                                return null;
                                              },
                                              child: Text('Change Password'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'Change Password',
                        ),
                      ),
                    ),
                    BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) async {
                        if (state is AccountDeleted) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Account Has Been Deleted',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 5),
                          );
                          final checkLoginStatus =
                              BlocProvider.of<LoginBloc>(context);
                          final _prefs = sharedPreference();
                          await _prefs.removeUsername();
                          checkLoginStatus.add(CheckLoginStatus());
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          alignment: Alignment.bottomCenter,
                          child: OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text(
                                      'Are You Sure?',
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          bloc.add(
                                            DeleteAccount(
                                              username:
                                                  username_controller.text,
                                            ),
                                          );
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: Text("No"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
