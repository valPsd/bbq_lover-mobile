//Amm
// ignore_for_file: prefer_const_constructors

import 'package:bbq_lover/pages/menu.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

class DeliveryMenu extends StatefulWidget {
  const DeliveryMenu({Key? key}) : super(key: key);

  @override
  DeliveryMenuState createState() => DeliveryMenuState();
}

class DeliveryMenuState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
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
            'เดลิเวอรี่',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 30,fontWeight:FontWeight.bold),
          ),
           centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()))
              },
              icon: const Icon(Icons.shopping_basket),
              color: Colors.black,
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Menu(
                                type: "set",
                              )))
                },
                child: Container(
                  height: 180,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffffd9bf),
                    border: Border.all(
                      color: Color(0xffffd9bf),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset("asset/images/set_cartoon.png",
                          width: 200, height: 120),
                      Text(
                        "เซ็ตหมูกระทะ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Minimal'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Menu(
                                type: "meat",
                              )))
                },
                child: Container(
                  height: 180,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffffd9bf),
                    border: Border.all(
                      color: Color(0xffffd9bf),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset("asset/images/fresh.png",
                          width: 200, height: 120),
                      Text(
                        "เนื้อหมู/อาหารทะเลแบบแพ็ค",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Minimal'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Menu(
                                type: "other",
                              )))
                },
                child: Container(
                  height: 180,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffffd9bf),
                    border: Border.all(
                      color: Color(0xffffd9bf),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset("asset/images/veg.png",
                          width: 200, height: 120),
                      Text(
                        "เครื่องเคียงอื่นๆ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Minimal'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
