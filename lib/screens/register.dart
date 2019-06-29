import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  // Method
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('name = $nameString, email = $emailString, password = $passwordString');
        }
      },
    );
  }

  Widget nameText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.face,
            color: Colors.blue,
            size: 36.0,
          ),
          labelText: 'Display Name :',
          labelStyle: TextStyle(color: Colors.blue),
          helperText: 'Type Your Name',
          helperStyle: TextStyle(color: Colors.blue),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Name in Blank';
          }
        },
        onSaved: (String value) {
          nameString = value;
        },
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.red,
            size: 36.0,
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: Colors.red),
          helperText: 'you@email.com',
          helperStyle: TextStyle(color: Colors.red),
        ),
        validator: (String value) {
          if (!((value.contains('@')) && (value.contains('.')))) {
            return 'Keep Email Format';
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
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.orange,
            size: 36.0,
          ),
          labelText: 'Password :',
          labelStyle: TextStyle(color: Colors.orange),
          helperText: 'More 6 Charactor',
          helperStyle: TextStyle(color: Colors.orange),
        ),
        validator: (String value) {
          if (value.length <= 5) {
            return 'Password More 6 Charactor';
          }
        },
        onSaved: (String value) {
          passwordString = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text('Register'),
        actions: <Widget>[uploadButton()],
      ),
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: [Colors.white, Colors.red[700]],
            radius: 3.0,
            center: Alignment.topCenter,
          )),
          padding: EdgeInsets.only(top: 60.0),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              nameText(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }
}
