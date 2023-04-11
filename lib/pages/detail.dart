// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Detail extends StatefulWidget {
  Detail({Key? key, required this.name}) : super(key: key);

  String name;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  int amount = 1;
  String image = "";
  var price = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    var collection = FirebaseFirestore.instance.collection('Menu');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['name'] == widget.name) {
        price = data['price'];
        image = data['image'];
      }
    }
    setState(() {});
  }

  subAmount() {
    if (amount > 1) amount -= 1;
  }

  addAmount() {
    amount += 1;
  }

  addToCart() {
    var total = int.parse(price) * amount;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.displayName)
        .collection('Cart')
        .add({'name': widget.name, 'amount': amount, 'price': total});
    Navigator.pop(context);
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
            child: Column(children: [
          image == ""
              ? Text("")
              : Image.network(
                  image,
                  width: 400,
                ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: 500,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ราคา", style: TextStyle(fontSize: 35)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                  Text(price.toString(),
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                  Text("บาท", style: TextStyle(fontSize: 35))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            setState(() {
                              subAmount();
                            })
                          },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                        primary: Color(0xFFFFD9BF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        '-',
                        style: TextStyle(
                            color: Colors.orange.shade900,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    amount.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            setState(() {
                              addAmount();
                            })
                          },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                        primary: Color(0xFFFFD9BF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        '+',
                        style: TextStyle(
                            color: Colors.orange.shade900,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () => addToCart(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(105, 15, 105, 15),
                    primary: Color(0xFFB4D3AA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    'เพิ่มลงตะกร้า',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  )),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
            ]),
          )
        ])));
  }
}
