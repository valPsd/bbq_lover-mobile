//Amm
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bbq_lover/pages/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../menu_con.dart';
import 'detail.dart';

class Menu extends StatefulWidget {
  Menu({Key? key, required this.type}) : super(key: key);

  String type;

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<MenuCon> listMenu = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var collection = FirebaseFirestore.instance.collection('Menu');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['type'] == widget.type) {
        if (data['show'] == true) {
          listMenu.add(
              MenuCon(data['image'], data['name'], data['price'].toString()));
        }
      }
    }
    setState(() {});
  }

  List<Widget> menuList() {
    List<Widget> list = [];
    for (var item in listMenu) {
      list.add(GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(name: item.name.toString())))
        },
        child: Row(
          children: [
            Image.network(item.image.toString(), width: 100, height: 100),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                Text(
                  item.price.toString(),
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ));
      list.add(
        Divider(
          color: Colors.grey,
          indent: 20,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffd9bf),
        appBar: AppBar(
          backgroundColor: Color(0xfffe9f60),
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
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: menuList(),
            ),
          ),
        ));
  }
}
