import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:new_authen/screens/read_data.dart';
import 'package:new_authen/screens/write_data.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String displayName;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget myWidget = ReadData();

  // Method

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      displayName = firebaseUser.displayName;
      print('displayName = $displayName');
    });
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        print('You Click Sign Out');
        mySignOut();
      },
    );
  }

  Future<void> mySignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      exit(0);
    });
  }

  Widget showTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text('My Service'),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Login by $displayName',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red[200]),
            child: myHeaderDrawer(),
          ),
          readData(),
          writeData(),
          showExit(),
        ],
      ),
    );
  }

  Widget showExit() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text(
        'Sign Out and Exit',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        Navigator.of(context).pop();
        mySignOut();
      },
    );
  }

  Widget readData() {
    return ListTile(
      leading: Icon(Icons.library_books),
      title: Text(
        'Read All Data',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = ReadData();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget writeData() {
    return ListTile(
      leading: Icon(Icons.build),
      title: Text(
        'Write Data on FireStore',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = WriteData();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      height: 10,
    );
  }

  Widget myHeaderDrawer() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: Image.asset('images/logo.png'),
          ),
          mySizeBox(),
          Text('Hello Drawer')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: showTitle(),
        actions: <Widget>[signOutButton()],
      ),
      body: myWidget,
      drawer: menuDrawer(),
    );
  }
}
