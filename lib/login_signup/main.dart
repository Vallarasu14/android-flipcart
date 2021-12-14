import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercart_sample/databasehandler/dbhelper.dart';
import 'package:fluttercart_sample/pages/home_page.dart';
import 'package:fluttercart_sample/login_signup/signup_page.dart';

import '../email_validator.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  var dbHelper;

  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  logIn() async {
    String username = _username.text;
    String email = _email.text;
    String passwd = _password.text;

    final form = _formKey.currentState;
    if (form!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Shopping()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  )),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'WELCOME',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 35),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email-id';
                          }
                          if (!validateEmail(value)) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'E-mail',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18))),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        validator: (val) =>
                            val!.length == 0 ? "please enter password" : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                            onPressed: () {}, child: const Text('Forgot Password')),
                      ],
                    ),
                    RaisedButton(
                      onPressed: (){
                        setState(() {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const Shopping()));
                        });
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('No Account Yet?'),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Signup_Page()));
                                });
                              },
                              child: const Text(
                                'Create Account',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
