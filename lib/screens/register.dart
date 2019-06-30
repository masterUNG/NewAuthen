import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_authen/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $nameString, email = $emailString, password = $passwordString');
          registerFirebase();
        }
      },
    );
  }

  Future<void> registerFirebase() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      String errorString = response.message;
      print('error = $errorString');
      showAlertDialog(errorString);
    });
  }

  Future<void> setupDisplayName() async {
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = nameString;
      response.updateProfile(updateInfo);

      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
    });
  }

  void showAlertDialog(String messageString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cannot Register',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(messageString),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget nameText() {
    return Container(
      width: 200.0,
      child: TextFormField(
        keyboardType: TextInputType.text,
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
        keyboardType: TextInputType.emailAddress,
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
