import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/painting.dart';
import 'package:new_authen/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  double mySize = 180.0;

  // Method
  Widget signInButton() {
    return RaisedButton(
      color: Colors.red[600],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.red[100],
      child: Text('Sign Up'),
      onPressed: () {
        print('You Click SignUp');

        // Create Route
        var registerRoute = MaterialPageRoute(builder: (BuildContext context) => Register());
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
        decoration: InputDecoration(
            labelText: 'Email :',
            hintText: 'you@email.com',
            labelStyle: TextStyle(color: Colors.red[900])),
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
            labelStyle: TextStyle(color: Colors.red[900])),
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
      resizeToAvoidBottomPadding: false,
      body: Container(
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
    );
  }
}
