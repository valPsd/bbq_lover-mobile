// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'cart.dart';

class Reservation extends StatefulWidget {
  Reservation({Key? key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final getTel = TextEditingController();
  bool isAChecked = false;
  bool isBChecked = false;
  var zone;
  String dateBook = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String timeBook = 'เลือกเวลาจองโต๊ะ';
  var selectedPeep;
  List<String> timesChoose = [
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00'
  ];
  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(child: Text("1"), value: "1"),
    DropdownMenuItem(child: Text("2"), value: "2"),
    DropdownMenuItem(child: Text("3"), value: "3"),
    DropdownMenuItem(child: Text("4"), value: "4"),
    DropdownMenuItem(child: Text("5"), value: "5"),
  ];
  final formKey = GlobalKey<FormState>();

  final getDate = TextEditingController();

  List<Widget> CreateTimeChoice() {
    return timesChoose
        .map((item) => Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: GestureDetector(
                onTap: () {
                  setState(() => timeBook = item);
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: [
                    Text(
                      item,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffe9f60),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFD9BF),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "จองโต๊ะ",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onTap: () => {Navigator.pop(context)},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_basket_outlined),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("asset/images/banner2.jpg"),
                Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 170,
                        height: 60,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFD9BF),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'd MMM, yyyy',
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateLabelText: 'เลือกวันที่จองโต๊ะ',
                          onChanged: (val) => dateBook = val,
                        )),
                    Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                    Container(
                        width: 170,
                        height: 60,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFD9BF),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_rounded,
                                color: Colors.black,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                              Text(
                                timeBook,
                                style: timeBook == 'เลือกเวลาจองโต๊ะ'
                                    ? TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade600)
                                    : TextStyle(
                                        fontSize: 25, color: Colors.black),
                              ),
                            ],
                          ),
                          onTap: () async {
                            return await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'เลือกเวลาจองโต๊ะ',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                          children: CreateTimeChoice()),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 25),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        )),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD9BF),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people_alt_rounded,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Container(
                        width: 130,
                        child: DropdownButtonFormField<String>(
                            hint: Text('จำนวนท่าน'),
                            value: selectedPeep,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPeep = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "กรุณาเลือกจำนวนท่าน";
                              }
                              return null;
                            },
                            items: dropdownItems),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  width: 300,
                  height: 60,
                  padding:
                      EdgeInsets.only(top: 4, left: 5, right: 16, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color(0xFFFFD9BF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      hintText: 'เบอร์โทรศัพท์ที่สามารถติดต่อได้',
                      hintStyle:
                          TextStyle(fontSize: 20, color: Colors.grey.shade600),
                    ),
                    style: TextStyle(fontSize: 20),
                    controller: getTel,
                    validator: (value) {
                      if (value == "") {
                        return "กรุณาใส่เบอร์โทรศัพท์";
                      } else if (!RegExp(r'0+[0-9]').hasMatch(value!)) {
                        return "เบอร์โทรศัพท์ต้องขึ้นต้นด้วย 0";
                      } else if (value.length < 10 || value.length > 10) {
                        return "เบอร์โทรศัพท์ต้องมี 10 หลัก";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    padding: EdgeInsets.all(15),
                    width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Color(0xFFFFD9BF),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'โซนที่นั่ง',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                          Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: "A (ข้างในอุ่นจัง)",
                                      groupValue: zone,
                                      fillColor: MaterialStateProperty.all(
                                          Colors.green),
                                      onChanged: (String? value) {
                                        setState(() {
                                          zone = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      "A (ข้างในอุ่นจัง)",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: "B (ข้างนอกร้อนจัง)",
                                      groupValue: zone,
                                      fillColor: MaterialStateProperty.all(
                                          Colors.green),
                                      onChanged: (String? value) {
                                        setState(() {
                                          zone = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      "B (ข้างนอกร้อนจัง)",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ])),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                    ElevatedButton(
                        onPressed: () => {
                              if (formKey.currentState!.validate())
                                {
                                  if (timeBook == 'เลือกเวลาจองโต๊ะ')
                                    {
                                      Fluttertoast.showToast(
                                          msg: "กรุณาเลือกเวลาในการจอง",
                                          gravity: ToastGravity.BOTTOM)
                                    }
                                  else if (zone == null)
                                    {
                                      Fluttertoast.showToast(
                                          msg: "กรุณาเลือกโซนที่นั่ง",
                                          gravity: ToastGravity.BOTTOM)
                                    }
                                  else
                                    {confirmAlert()}
                                }
                            },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                          primary: Color(0xFFB4D3AA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'ยืนยันการจอง',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ))
                  ],
                )
              ],
            ),
          )),
        ));
  }

  confirmAlert() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'การจองโต๊ะ',
              style: TextStyle(fontSize: 30),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                  children: <Widget>[Text("ยืนยันข้อมูลการจองหรือไม่?")]),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  writeData();
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  writeData() async {
    bool isAvalible = false;
    var table = 1;
    for (var i = 1; i < 6; i++) {
      var collection = FirebaseFirestore.instance
          .collection('Tables')
          .doc(i.toString())
          .collection(dateBook)
          .doc(timeBook);
      var querySnapshot = await collection.get();
      if (querySnapshot.exists) {
        isAvalible = false;
      } else {
        isAvalible = true;
        table = i;
        break;
      }
    }
    if (isAvalible == true) {
      String resNum = '';
      var rand = Random();
      for (var i = 0; i < 6; i++) {
        resNum += rand.nextInt(9).toString();
      }
      FirebaseFirestore.instance.collection('Reservation').add({
        'date': dateBook,
        'name': firebaseUser!.displayName,
        'resNum': resNum,
        'tel': getTel.text,
        'time': timeBook,
        'totalpeep': selectedPeep,
        'zone': zone,
        'table': table
      });

      FirebaseFirestore.instance
          .collection('Tables')
          .doc(table.toString())
          .collection(dateBook)
          .doc(timeBook)
          .set({'resNum': resNum});
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "ทำการจองสำเร็จ", gravity: ToastGravity.BOTTOM);
    } else {
      Fluttertoast.showToast(
          msg: "โต๊ะในวันหรือเวลาที่ท่านเลือกไม่ว่าง กรุณาเปลี่ยนวันหรือเวลา",
          gravity: ToastGravity.BOTTOM);
    }
  }
}
