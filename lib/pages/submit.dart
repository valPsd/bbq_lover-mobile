//Amm
// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:bbq_lover/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cart_detail.dart';

class SubmitPage extends StatefulWidget {
  SubmitPage(
      {Key? key,
      required this.address,
      required this.tel,
      required this.more,
      required this.payment})
      : super(key: key);

  var address, tel, more, payment;
  @override
  submitState createState() => submitState();
}

class submitState extends State<SubmitPage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  List<CartDetail> carts = [];
  int totalPrice = 0;
  String orderNum = '';
  List<String> orders = [];

  @override
  void initState() {
    getOrderNum();
    super.initState();
  }

  getOrderNum() {
    var rand = Random();
    for (var i = 0; i < 6; i++) {
      orderNum += rand.nextInt(9).toString();
    }
    checkOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffe9f60),
        body: Container(
            padding: EdgeInsets.all(30),
            child: Column(children: <Widget>[
              Image.asset("asset/images/BBQ Lover_round.png",
                  width: 200, height: 200),
              SizedBox(
                height: 15,
              ),
              Column(children: [
                Text(
                  "สั่งซื้อสำเร็จ",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "คำสั่งซื้อหมายเลข : " + orderNum,
                  style: TextStyle(fontSize: 35, color: Color(0xffB4D3AA)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "ร้านค้าได้รับคำสั่งซื้อของคุณแล้ว",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Text(
                  "กำลังเตรียมอาหารและจัดส่งให้กับคุณ",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "สามารถตรวจสอบคำสั่งซื้อของคุณได้ที่ *ตรวจสอบการสั่งซื้อ*",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(children: <Widget>[
                  Image.asset("asset/images/onlieDeli_icon2.png",
                      width: 200, height: 200),
                ]),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home())),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                    primary: Color(0xFFB4D3AA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('ปิด',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ),
              ])
            ])));
  }

  checkOrder() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.displayName)
        .collection('Cart');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      CartDetail cart = CartDetail(data['name'], data['price'], data['amount'], queryDocumentSnapshot.id);
      carts.add(cart);
    }

    for (CartDetail item in carts) {
      totalPrice += item.price;
    }

    for (var item in carts) {
      orders.add(item.name.toString() + " x" + item.amount.toString());
    }

    setState(() {});
    writeData();
  }

  writeData() {
    print(orders);
    print(totalPrice);
    FirebaseFirestore.instance.collection('Delivery').add({
      'name': firebaseUser!.displayName,
      'address': widget.address,
      'tel': widget.tel,
      'more': widget.more,
      'orderNum': orderNum,
      'payment': widget.payment,
      'total': totalPrice,
      'order': orders
    });
    deleteData();
  }

  deleteData() {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.displayName)
        .collection('Cart');

    for (var item in carts) {
      collection.doc(item.id).delete();
    }
  }
}
