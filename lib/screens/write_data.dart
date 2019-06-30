import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WriteData extends StatefulWidget {
  @override
  _WriteDataState createState() => _WriteDataState();
}

class _WriteDataState extends State<WriteData> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String messageString, nameString, uidString;

  // Method

  @override
  void initState() {
    super.initState();
    findLogin();
  }

  Future<void> findLogin() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    nameString = firebaseUser.displayName;
    uidString = firebaseUser.uid;
  }

  Widget messageText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Message :'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          messageString = value;
        },
      ),
    );
  }

  Widget saveButton() {
    return RaisedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Save'),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          postFireStore();
        }
      },
    );
  }

  Future<void> postFireStore() async {
    print('name = $nameString, uid = $uidString, message = $messageString');

    Map<String, dynamic> map = Map();
    map['Message'] = messageString;
    map['Name'] = nameString;
    map['Uid'] = uidString;

    Firestore firestore = Firestore.instance;
    await firestore
        .collection('dataMessage')
        .document()
        .setData(map)
        .then((response) {
          print('Success Save Data');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[messageText(), saveButton()],
        ),
      ),
    );
  }
}
