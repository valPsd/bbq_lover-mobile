// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bbq_lover/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class StartPage extends StatefulWidget {
  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Bbqlogin()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffe9f60),
      body: Center(
        child: Image(
          image: AssetImage('asset/images/BBQ Lover_round.png'),
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
