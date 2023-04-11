//Amm
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class ReservationDetail extends StatefulWidget {
  const ReservationDetail({Key? key}) : super(key: key);

  @override
  reservationState createState() => reservationState();
}

class reservationState extends State<StatefulWidget> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var date, name, resNum, table, tel, time, totalpeep, zone, docId;
  List<String> tables = [];
  bool isLoaded = false, isFound = false;
  get nameController => null;
  get passwordController => null;

  @override
  void initState() {
    CheckTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var HexColors;
    return Scaffold(
        backgroundColor: Color(0xfffe9f60),
        appBar: AppBar(
          backgroundColor: Color(0xffffd9bf),
          leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(
              Icons.navigate_before,
              size: 38,
              color: Colors.black,
            ),
          ),
          title: Text(
            'การจองโต๊ะ',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(padding: EdgeInsets.all(20), child: checkIfFound()));
  }

  Widget checkIfFound() {
    if (isFound) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "asset/images/main.png",
              height: 120,
              width: 120,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Text(
            "โต๊ะที่ :$table ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35,
                color: Color(0xffB4D3AA),
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "วันที่จอง",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                    height: 30,
                    width: 150,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffffd9bf),
                          labelText: '$date',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    )),
              ]),
              SizedBox(
                width: 50,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "เวลาที่จอง",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                    height: 30,
                    width: 150,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffffd9bf),
                          labelText: '$time',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    )),
              ]),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "เบอร์โทรติดต่อ",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                  height: 30,
                  width: 150,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffffd9bf),
                        labelText: '$tel',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                  )),
            ]),
          ]),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "จำนวนท่าน",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                    height: 30,
                    width: 150,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffffd9bf),
                          labelText: '$totalpeep',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    )),
              ]),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "โซนที่นั่ง",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                    height: 30,
                    width: 150,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffffd9bf),
                          labelText: '$zone',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    )),
              ]),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Spacer(),
          Text(
            "*โปรดมาตามวันและเวลาที่ได้ทำการจองไว้และแสดงหน้านี้ต่อเจ้าหน้าที่มิเช่นนั้นจะถือว่าสละสิทธิ์",
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              onPressed: () => confirmAlert(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(105, 15, 105, 15),
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('ยกเลิกการจอง',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      );
    } else {
      return Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 250, 0, 0)),
            Text(
              'คุณยังไม่ได้ทำการจองโต๊ะ',
              style: TextStyle(fontSize: 40, color: Colors.grey.shade400),
            ),
          ],
        ),
      );
    }
  }

  CheckTable() async {
    var collection = FirebaseFirestore.instance.collection('Reservation');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['name'] == firebaseUser!.displayName) {
        docId = queryDocumentSnapshot.id;
        date = data['date'];
        name = data['name'];
        resNum = data['resNum'];
        table = data['table'];
        tel = data['tel'];
        time = data['time'];
        totalpeep = data['totalpeep'];
        zone = data['zone'];

        isFound = true;
      }
    }
    setState(() {
      isLoaded = true;
    });
  }

  confirmAlert() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'ยกเลิกการจอง',
              style: TextStyle(fontSize: 30),
            ),
            content: SingleChildScrollView(
              child:
                  ListBody(children: <Widget>[Text("ยืนยันการยกเลิกหรือไม่?")]),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteReservation();
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

  deleteReservation() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Reservation');

    collection
        .doc(docId)
        .delete()
        .then((value) => Fluttertoast.showToast(
            msg: "ยกเลิกการจองเรียบร้อย", gravity: ToastGravity.BOTTOM))
        .catchError((error) => print("Failed to delete user: $error"));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
}
