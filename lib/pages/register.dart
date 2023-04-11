// ignore_for_file: prefer_const_constructors
import 'package:bbq_lover/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final getFullName = TextEditingController();
  final getEmail = TextEditingController();
  final getPassword = TextEditingController();
  final getConPass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void regis() async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: getEmail.text, password: getPassword.text);
      User user = result.user!;
      user.updateDisplayName(getFullName.text);
      Fluttertoast.showToast(
          msg: "สร้างบัญชีเรียบร้อย", gravity: ToastGravity.BOTTOM);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Bbqlogin()));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffe9f60),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onTap: () => {Navigator.pop(context)},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/images/bg_regis.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Image(
                        image: AssetImage('asset/images/BBQ Lover_round.png'),
                        width: 120,
                        height: 120,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                      Text(
                        'ลงทะเบียน',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                      Container(
                        width: 300,
                        height: 65,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name Surname',
                              hintStyle: TextStyle(fontSize: 20),
                              errorStyle: TextStyle(fontSize: 15)),
                          style: TextStyle(fontSize: 20),
                          controller: getFullName,
                          validator: (value) {
                            if (value == "") {
                              return "ต้องกรอก Name Surname";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                      Container(
                        width: 300,
                        height: 65,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 20),
                              errorStyle: TextStyle(fontSize: 15)),
                          style: TextStyle(fontSize: 20),
                          controller: getEmail,
                          validator: (value) {
                            if (value == "") {
                              return "ต้องกรอก Email";
                            } else if (!validateEmail(value!)) {
                              return "รูปแบบ email ไม่ถูกต้อง ตัวอย่างเช่น bbq@example.com";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                      Container(
                        width: 300,
                        height: 65,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                            obscureText: _obscureText1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 20),
                              errorStyle: TextStyle(fontSize: 15),
                              suffixIcon: IconButton(
                                  icon: Icon(_obscureText1
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText1 = !_obscureText1;
                                    });
                                  }),
                            ),
                            style: TextStyle(fontSize: 20),
                            controller: getPassword,
                            validator: (value) {
                              if (value == "") {
                                return "ต้องกรอก Password";
                              } else if (value!.length < 6) {
                                return "Password ต้องมีอย่างน้อย 6 ตัว";
                              } else if (value != getConPass.text) {
                                return "Password กับ Confirm Password ต้องตรงกัน";
                              }
                              return null;
                            }),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                      Container(
                        width: 300,
                        height: 65,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                            obscureText: _obscureText2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(fontSize: 20),
                              errorStyle: TextStyle(fontSize: 15),
                              suffixIcon: IconButton(
                                  icon: Icon(_obscureText2
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  }),
                            ),
                            style: TextStyle(fontSize: 20),
                            controller: getConPass,
                            validator: (value) {
                              if (value == "") {
                                return "ต้องกรอก Confirm Password";
                              } else if (value!.length < 6) {
                                return "Confirm Password ต้องมีอย่างน้อย 6 ตัว";
                              } else if (value != getPassword.text) {
                                return "Password กับ Confirm Password ต้องตรงกัน";
                              }
                              return null;
                            }),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                      ElevatedButton(
                          onPressed: () => {
                                if (formKey.currentState!.validate()) {regis()}
                              },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                            primary: Color(0xFFB4D3AA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ))
                    ],
                  ),
                ),
              )),
        ));
  }

  bool validateEmail(String input) {
    RegExp email = RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    if (email.hasMatch(input)) {
      return true;
    }
    return false;
  }

  bool validatePassAndConPass() {
    if (getPassword.text == getConPass.text) {
      return true;
    }
    return false;
  }
}
