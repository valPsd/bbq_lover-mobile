//Amm
// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:ui';
import 'package:bbq_lover/pages/home.dart';
import 'package:bbq_lover/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bbqlogin extends StatefulWidget {
  const Bbqlogin({Key? key}) : super(key: key);
  @override
  BbqloginState createState() => BbqloginState();
}

class BbqloginState extends State<StatefulWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  signIn() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((user) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
        Fluttertoast.showToast(
            msg: "เข้าสู่ระบบเรียบร้อย", gravity: ToastGravity.BOTTOM);
        return user;
      });
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "email หรือ รหัสผ่านไม่ถูกต้อง", gravity: ToastGravity.BOTTOM);
      } else if (error.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "email หรือ รหัสผ่านไม่ถูกต้อง", gravity: ToastGravity.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/images/bg_login.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),
            Image.asset("asset/images/BBQ Lover_round.png",
                width: 200, height: 200),
            Text(
              "เข้าสู่ระบบ",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Minimal'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    errorStyle: TextStyle(fontSize: 18)),
                validator: (String? value) {
                  if (value == "") {
                    return "ต้องกรอก Email";
                  } else if (validateEmail(value!) == false) {
                    return "รูปแบบEmailไม่ถูกต้อง ตัวอย่างเช่น 620107030010@dpu.ac.th";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    errorStyle: TextStyle(fontSize: 20)),
                validator: (String? value) {
                  if (value == "") {
                    return "ต้องกรอก Password ";
                  } else if (value!.length < 6) {
                    return "Password ต้องมีอย่างน้อย6ตัวอักษร ";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () => {
                  if (formkey.currentState!.validate()) {signIn()}
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(120, 15, 129, 15),
                    primary: Color(0xFFB4D3AA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                child: Text('Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ยังไม่มีบัญชี?',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    "ลงทะเบียน",
                    style: TextStyle(
                        color: Color(0xffB4D3AA),
                        fontSize: 20,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )),
            Text(
              "",
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
    ));
  }

  bool validateEmail(String value) {
    RegExp regex2 = new RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    return (!regex2.hasMatch(value)) ? false : true;
  }
}
