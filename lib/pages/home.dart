// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bbq_lover/pages/delivery_detail.dart';
import 'package:bbq_lover/pages/detail.dart';
import 'package:bbq_lover/pages/login.dart';
import 'package:bbq_lover/pages/mappages.dart';
import 'package:bbq_lover/pages/reservation.dart';
import 'package:bbq_lover/pages/reservation_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'cart.dart';
import 'delivery_menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Map<String, String> imageAndName = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffe9f60),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              backgroundColor: Color(0xFFFFD9BF),
              iconTheme: IconThemeData(color: Colors.black),
              title: Image.asset(
                'asset/images/BBQ Lover_noBG.png',
                width: 50,
                height: 50,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_basket_outlined),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
                ),
              ],
              pinned: false,
              floating: true,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSlideshow(
                width: double.infinity,
                initialPage: 0,
                indicatorColor: Colors.orangeAccent,
                indicatorBackgroundColor: Color(0xFFFFD9BF),
                children: [
                  Image.asset(
                    'asset/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'asset/images/banner2.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'asset/images/banner3.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
                autoPlayInterval: 5000,
                isLoop: true,
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              //ส่วนปุ่มจองโต๊ะกับ delivery
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1.0, color: Color(0xFFFFD9BF)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reservation()))
                            },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD9BF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade700.withOpacity(0.10),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'asset/images/reservation_icon.png',
                                width: 90,
                                height: 90,
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                            Text(
                              'จองโต๊ะ',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ],
                        )),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 40, 0)),
                    GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeliveryMenu()))
                            },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD9BF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade700.withOpacity(0.10),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'asset/images/delivery_icon.png',
                                width: 90,
                                height: 90,
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                            Text(
                              'เดลิเวอรี่',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ],
                        ))
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              //ส่วนเมนูยอดนิยม
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                  Text(
                    'เมนูยอดนิยม',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              Column(
                children: createPopList(),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
          child: Container(
        color: Color(0xFFFFD9BF),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Image.asset(
                    'asset/images/BBQ Lover_round.png',
                    width: 80,
                    height: 80,
                  ),
                  Text(
                    firebaseUser!.displayName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xfffe9f60),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Text(
                    firebaseUser!.email.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_rounded),
              title: Text('ตรวจสอบการจอง',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReservationDetail()));
              },
            ),
            ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text('ตรวจสอบการสั่งซื้อ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeliveryDetail()));
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('ติดต่อเรา',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mappage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('ออกจากระบบ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Bbqlogin()));
              },
            ),
          ],
        ),
      )),
    );
  }

  //สร้างเมนูยอดนิยม
  List<Widget> createPopList() {
    List<Widget> widgets = [];
    imageAndName.forEach((key, value) {
      widgets.add(
        GestureDetector(
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(name: value)))
                },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Color(0xFFFFD9BF),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageUrl: key,
                        height: 150,
                        fit: BoxFit.fill),
                  ),
                  ListTile(
                    title: Text(
                      value,
                      style: TextStyle(fontSize: 20, color: Colors.orange),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )),
      );
      widgets.add(Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)));
    });
    return widgets;
  }

  Future getData() async {
    var collection = FirebaseFirestore.instance.collection('Menu');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['isPop'] == true) {
        if (data['show'] == true) {
          imageAndName[data['image']] = data['name'];
        }
      }
    }
    setState(() => imageAndName);
  }
}
