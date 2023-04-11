// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mappage extends StatefulWidget {
  const Mappage({Key? key}) : super(key: key);

  @override
  _MappageState createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var leading;
    return Scaffold(
      backgroundColor: Color(0xfffe9f60),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD9BF),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.navigate_before,
            size: 38,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ติดต่อเรา',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            width: 500,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(13.870084460531396, 100.55064238625272),
                ),
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(13.870084460531396,
                    100.55064238625272), //กำหนดพิกัดเริ่มต้นบนแผนที่
                zoom: 15, //กำหนดระยะการซูม สามารถกำหนดค่าได้ 0-20
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Color(0xffb4d3aa),
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "110/1-4 ถนน ประชาชื่น แขวง ทุ่งสองห้อง เขต หลักสี่ กทม 10210",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Color(0xffb4d3aa),
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "02-231-1241",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Color(0xffb4d3aa),
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "เปิดทำการเวลา 16:00 - 00:00 น.",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
