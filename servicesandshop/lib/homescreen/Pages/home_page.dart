import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servicesandshop/Login/auth.dart';
import 'package:servicesandshop/Login/auth_provider.dart';
import 'package:servicesandshop/homescreen/Carouselimgs/carouselimgs.dart';
import 'package:servicesandshop/homescreen/Categories/Horizontallists.dart';
import 'package:servicesandshop/homescreen/Drawer/Sidedrawer.dart';
import 'package:servicesandshop/homescreen/Products/product.dart';

Carousal cal = Carousal();

class Homepage extends StatelessWidget {
  static const String id = 'Homepage';
  const Homepage({this.onSignedOut});
  final VoidCallback onSignedOut;
  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Colors.black,
                    Colors.white,
                  ],)
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            '___S_&_S___',
            style: TextStyle(color: Colors.white),
          ),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "There is no messages for you",
                );
              },),
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "There is no notifications for you",
                );
              },),
          IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.redAccent),
              onPressed: () {
                _signOut(context);
     }),
        ],
      ),
      drawer: Sidedrawer(),
      body: ListView(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Categories',
              style: TextStyle(
                  color: Color(0xFF515C6F),
                  fontSize: 37,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NeusaNextPro'),
            ),
          ),
          Horizontallist(),
          Text(
            'Latest Services',
            style: TextStyle(
                color: Color(0xFF515C6F),
                fontSize: 35,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontFamily: 'NeusaNextPro'),
          ),
          cal.carouselimgs,
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Recent products services',
              style: TextStyle(
                  color: Color(0xFF515C6F),
                  fontSize: 17,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NeusaNextPro'),
            ),
          ),
          Container(height: 450.0, child: Product()),
        ],
      ),
    );
  }
}
