import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servicesandshop/homescreen/Drawer/Profile.dart';
import 'package:servicesandshop/homescreen/Products/product.dart';
import 'package:servicesandshop/homescreen/Drawer/About.dart';
class Sidedrawer extends StatefulWidget {
  @override
  _SidedrawerState createState() => _SidedrawerState();
}

class _SidedrawerState extends State<Sidedrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(

            accountEmail: Text("${user.email}",style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
            accountName: null,
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),

              ),
              onTap: (){Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) =>ProfilePage()));}
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.deepPurpleAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          ListTile(
            title: Text("Homepage"),
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text("My Account"),
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, new MaterialPageRoute(
                  builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            title: Text("My orders"),
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onTap: () {
              Fluttertoast.showToast(
                  msg: "This feature will be available with shopping",
              );
            },
          ),
          ListTile(
            title: Text("Categories"),
            leading: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, new MaterialPageRoute(
                  builder: (context) => Product()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Settings"),
            leading: Icon(
              Icons.settings,
              color: Colors.blueAccent,
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: "This feature will be available soon",
              );
            },
          ),
          ListTile(
            title: Text("About"),
            leading: Icon(
              Icons.help,
              color: Colors.greenAccent,
            ),
            onTap: () {
              Navigator.push(
                context,MaterialPageRoute(builder: (context)=>About(),)
              );
            },
          ),
        ],
      ),
    );
  }
}
