import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("Updating Personal Info");
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: Icon(Icons.person_add_rounded),
                ),
              ),
              Container(
                margin: EdgeInsets.all(7),
                child: TextFormField(
                  initialValue: "Fullname",
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
                  initialValue: "Username",
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
                margin: EdgeInsets.all(7),
                child: TextFormField(
                  initialValue: "Password",
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
            ],
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(Color color, String message, context) {
  final snackBar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    backgroundColor: color,
    duration: Duration(seconds: 4),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
