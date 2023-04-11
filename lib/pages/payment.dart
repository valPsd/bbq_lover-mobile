// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:bbq_lover/pages/submit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Payment extends StatefulWidget {
  Payment(
      {Key? key,
      required this.address,
      required this.tel,
      required this.more,
      required this.payment})
      : super(key: key);

  var address, tel, more, payment;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takeImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffe9f60),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFD9BF),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "ชำระเงิน",
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
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color(0xFFFFD9BF),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Text(
                      "QR CODE พร้อมเพย์",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        "asset/images/qr_promptpay.PNG",
                        width: 260,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              image != null
                  ? Image.file(
                      image!,
                      width: 80,
                      height: 120,
                    )
                  : Container(),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Container(
                width: 260,
                height: 40,
                child: ElevatedButton(
                    onPressed: () async {
                      return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'เพิ่มรูปภาพ',
                                style: TextStyle(fontSize: 30),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(children: <Widget>[
                                  GestureDetector(
                                    onTap: () => takeImage(),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "asset/images/camera_icon.png",
                                          width: 60,
                                          height: 60,
                                        ),
                                        Text(
                                          'Take a photo',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                  GestureDetector(
                                    onTap: () => pickImage(),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "asset/images/gallery_icon.png",
                                          width: 60,
                                          height: 60,
                                        ),
                                        Text(
                                          'Choose From gallery',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                        Text(
                          "แนบหลักฐานการชำระเงิน",
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    )),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
              Container(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubmitPage(
                                address: widget.address,
                                tel: widget.tel,
                                more: widget.more,
                                payment: widget.payment)))
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "ยืนยันการชำระเงิน",
                      style: TextStyle(fontSize: 35),
                    )),
              ),
            ],
          ),
        )));
  }
}
