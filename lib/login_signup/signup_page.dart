import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercart_sample/databasehandler/dbhelper.dart';
import '../email_validator.dart';
import 'main.dart';
import '../model/user_model.dart';

class Signup_Page extends StatefulWidget {
  @override
  _Signup_PageState createState() => _Signup_PageState();
}

class _Signup_PageState extends State<Signup_Page> {
  final _formKey = GlobalKey<FormState>();

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  var dbHelper;

  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String username = _userName.text;
    String email = _email.text;
    String passwrd = _password.text;

    final form = _formKey.currentState;
    if (form!.validate()) {
      _formKey.currentState!.save();
      UserModel uModel = UserModel(username, passwrd, email);
      await dbHelper.saveData(uModel);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
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
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize:
                                  MediaQuery.of(context).size.height / 35),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _userName,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            validator: (val) => val!.length == 0
                                ? "please enter username"
                                : null,
                            decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.name,
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
                                hintText: 'Email',
                                labelText: 'E-mail',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.name,
                            obscureText: true,
                            validator: (val) => val!.length == 0
                                ? "please enter password"
                                : null,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18))),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        RaisedButton(
                          onPressed: () {
                            signUp();
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
