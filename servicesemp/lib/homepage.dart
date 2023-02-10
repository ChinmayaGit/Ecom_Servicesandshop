import 'package:servicesemp/Login/auth.dart';
import 'package:servicesemp/Login/auth_provider.dart';
import 'package:servicesemp/Pages/Database/database.dart';
import 'package:servicesemp/Pages/Profile.dart';
import 'package:servicesemp/Pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:servicesemp/Pages/setting.dart';


class Homepage extends StatefulWidget {
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
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _page =0;
  final List<Widget>_children =[
    Notifications(),
    Database(),
    ProfilePage(),
    Setting(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_page],
      bottomNavigationBar:CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.mail_outline, size: 30,color: Colors.white,),
          Icon(Icons.list, size: 30,color: Colors.white,),
          Icon(Icons.perm_identity, size: 30,color: Colors.white,),
          Icon(Icons.settings, size: 30,color: Colors.white,),

        ],
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        height: 55,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}

