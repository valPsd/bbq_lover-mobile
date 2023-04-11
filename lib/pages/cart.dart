// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bbq_lover/pages/delivery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cart_detail.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  List<CartDetail> carts = [];
  int totalPrice = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.displayName)
        .collection('Cart');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      CartDetail cart = CartDetail(data['name'], data['price'], data['amount'],
          queryDocumentSnapshot.id);
      carts.add(cart);
    }
    for (CartDetail item in carts) {
      totalPrice += item.price;
    }
    setState(() {});
  }

  calNewTotal(CartDetail cart) {
    totalPrice -= cart.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffe9f60),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD9BF),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "ตะกร้าของฉัน",
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
      body: Column(
        children: [
          Container(
              height: 550,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/images/bg_cart.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                  itemCount: carts.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      key: Key(carts[index].name),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          calNewTotal(carts[index]);
                          removeCart(index);
                          carts.removeAt(index);
                        });
                      },
                      confirmDismiss: (direction) async {
                        return await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'ลบรายการในตะกร้า',
                                  style: TextStyle(fontSize: 30),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                        'คุณต้องการลบรายการสินค้านี้หรือไม่?',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
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
                                  TextButton(
                                    child: const Text('Confirm',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 25)),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFFFD9BF),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(carts[index].name,
                                    style: TextStyle(fontSize: 25)),
                                Text('x' + carts[index].amount.toString(),
                                    style: TextStyle(fontSize: 25)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(carts[index].price.toString(),
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.green)),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0)),
                                    Text('บาท', style: TextStyle(fontSize: 25)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      background: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    );
                  })),
          Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            height: 112,
            decoration: BoxDecoration(
              color: Color(0xFFFFD9BF),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ราคารวม',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text(totalPrice.toString(),
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                        Text('บาท',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Delivery()))
                        },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(110, 5, 110, 5),
                      primary: Color(0xFFB4D3AA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'สั่งซื้อเลย',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  removeCart(int index) {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.displayName)
        .collection('Cart');

    collection.doc(carts[index].id).delete();
  }
}
