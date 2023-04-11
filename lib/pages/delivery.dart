//Amm
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbq_lover/pages/payment.dart';
import 'package:bbq_lover/pages/submit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);
  @override
  DeliveryState createState() => DeliveryState();
}

class DeliveryState extends State<StatefulWidget> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final addressController = TextEditingController();
  final telController = TextEditingController();
  final moreController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  var selectedPayment;

  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(child: Text("โอนเงิน"), value: "transfer"),
    DropdownMenuItem(child: Text("จ่ายปลายทาง"), value: "cash"),
  ];

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
            'กรอกรายละเอียด',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(children: <Widget>[
                Image.asset("asset/images/BBQ Lover_noBG.png",
                    width: 120, height: 120, alignment: Alignment.center),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "ชื่อ - นามสกุล : ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      firebaseUser!.displayName.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ที่อยู่",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffffd9bf),
                        labelText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        errorStyle: TextStyle(fontSize: 18),
                      ),
                      validator: (String? value) {
                        if (value == "") {
                          return "ต้องกรอก ที่อยู่ให้ครบถ้วน";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Color(0xffffd9bf),
                        border: Border.all(
                          color: Color(0xffffd9bf),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: telController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.add_ic_call_rounded,
                                color: Colors.black),
                            labelText: 'เบอร์โทรศัพท์ที่สามารถติดต่อได้',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 20),
                            errorStyle: TextStyle(fontSize: 18)),
                        validator: (String? value) {
                          if (value == "") {
                            return "ต้องกรอก เบอร์โทรศัพท์ติดต่อ";
                          } else if (value!.length < 10) {
                            return "เบอร์โทรศัพท์ ต้องมีอย่างน้อย10ตัวเลข ";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "รายละเอียดเพิ่มเติม",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: moreController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffffd9bf),
                          labelText: '',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffffd9bf),
                        border: Border.all(
                          color: Color(0xffffd9bf),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: DropdownButtonFormField<String>(
                          hint: Text('วิธีการชำระเงิน',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          value: selectedPayment,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPayment = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "กรุณาเลือกวิธีชำระเงิน";
                            }
                            return null;
                          },
                          items: dropdownItems),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          if (formkey.currentState!.validate())
                            {
                              if (selectedPayment == "transfer")
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Payment(
                                              address: addressController.text,
                                              tel: telController.text,
                                              more: moreController.text,
                                              payment: selectedPayment)))
                                }
                              else
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubmitPage(
                                              address: addressController.text,
                                              tel: telController.text,
                                              more: moreController.text,
                                              payment: selectedPayment)))
                                }
                            }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
                          primary: Color(0xffB4D3AA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('สั่งซื้อเลย',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}
