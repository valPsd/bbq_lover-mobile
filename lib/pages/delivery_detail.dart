// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class DeliveryDetail extends StatefulWidget {
  DeliveryDetail({Key? key}) : super(key: key);

  @override
  _DeliveryDetailState createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var name, address, tel, more, payment, total, orderNum, docId;
  List<String> orders = [];
  bool isLoaded = false, isFound = false;

  @override
  void initState() {
    CheckOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffe9f60),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD9BF),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "รายละเอียดคำสั่งซื้อ",
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
      ),
      body: SingleChildScrollView(
          child: isLoaded == true
              ? createWidget()
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget createWidget() {
    if (isFound) {
      return Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Image.asset(
            'asset/images/onlieDeli_icon.png',
            width: 150,
            height: 180,
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
          Text(
            'คำสั่งซื้อหมายเลข : $orderNum',
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB4D3AA)),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFFFD9BF)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ชื่อลูกค้า : $name', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Text('เบอร์โทรศัพท์ : $tel', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Text('ที่อยู่ : $address', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Text('รายการที่สั่ง :', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: createOrdersWidgets(),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Text('เพิ่มเติม : $more', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Text('การชำระเงิน : $payment', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(total.toString(),
                        style: TextStyle(fontSize: 30, color: Colors.red)),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                    Text('บาท', style: TextStyle(fontSize: 30)),
                  ],
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          ElevatedButton(
            onPressed: () => confirmAlert(),
            child: Text(
              'ยกเลิก',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.fromLTRB(140, 10, 140, 10),
              primary: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          )
        ],
      );
    } else {
      return Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 250, 0, 0)),
            Text(
              'คุณยังไม่ได้ทำการสั่งซื้อ',
              style: TextStyle(fontSize: 40, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }
  }

  List<Widget> createOrdersWidgets() {
    return orders
        .map((item) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ))
        .toList();
  }

  CheckOrder() async {
    var collection = FirebaseFirestore.instance.collection('Delivery');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['name'] == firebaseUser!.displayName) {
        docId = queryDocumentSnapshot.id;
        name = data['name'];
        address = data['address'];
        tel = data['tel'];
        more = data['more'];
        orderNum = data['orderNum'];
        payment = data['payment'];
        total = data['total'];
        for (var item in data['order']) {
          orders.add(item);
        }
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
              'ยกเลิกออเดอร์',
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
                  deleteOrder();
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

  deleteOrder() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Delivery');

    collection
        .doc(docId)
        .delete()
        .then((value) => {})
        .catchError((error) => print("Failed to delete user: $error"));

    Fluttertoast.showToast(
        msg: "ยกเลิกออเดอร์เรียบร้อย", gravity: ToastGravity.BOTTOM);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
}
