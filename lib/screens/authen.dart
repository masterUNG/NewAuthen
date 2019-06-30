import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/painting.dart';
import 'package:new_authen/screens/my_service.dart';
import 'package:new_authen/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  double mySize = 180.0;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      moveToService();
    }
  }

  void moveToService() {
    var serviceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.red[600],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('Click SignIn');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Welcome');
      moveToService();
    }).catchError((response) {
      String errorString = response.message;
      print('error = $errorString');
      myShowSnackBar(errorString);
    });
  }

  void myShowSnackBar(String messageString) {
    SnackBar snackBar = SnackBar(
      content: Text(messageString),
      duration: Duration(seconds: 8),
      backgroundColor: Colors.red[700],
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  bool checkSpace(String value) {
    bool result = value.isEmpty;
    return result;
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.red[100],
      child: Text('Sign Up'),
      onPressed: () {
        print('You Click SignUp');

        // Create Route
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  Widget showButton() {
    return Container(
      width: 200.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: signInButton(),
          ),
          mySizebox(),
          Expanded(
            child: signUpButton(),
          ),
        ],
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email :',
          hintText: 'you@email.com',
          labelStyle: TextStyle(color: Colors.red[900]),
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Please Fill Email in Blank';
          }
        },
        onSaved: (String value) {
          emailString = value;
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password :',
          hintText: 'More 6 Charactor',
          labelStyle: TextStyle(color: Colors.red[900]),
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Please Fill Password';
          }
        },
        onSaved: (String value) {
          passwordString = value;
        },
      ),
    );
  }

  Widget mySizebox() {
    return SizedBox(
      height: 15.0,
      width: 5.0,
    );
  }

  Widget showLogo() {
    return Container(
      width: mySize,
      height: mySize,
      child: Image.asset(
        'images/logo.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showText() {
    return Text(
      'New Auten',
      style: TextStyle(
        fontFamily: 'IndieFlower',
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.red[900],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue[600], Colors.blue[50]],
                  begin: Alignment.topCenter)),
          padding: EdgeInsets.only(top: 60.0),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              showLogo(),
              mySizebox(),
              showText(),
              emailText(),
              passwordText(),
              showButton(),
            ],
          ),
        ),
      ),
    );
  }
}
