import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text(
              'About',
            ),

        ),

        body: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: Container(
            decoration: BoxDecoration(

              gradient: LinearGradient(
                colors: [Colors.pink, Colors.blue],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "We provide services for all kind of electronic things",
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    "contact no.9776790204",
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Plot No-200/1295,kalinga nagar,inforent of tata ariana ",
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                  ),
                ),
                Center(
                  child: Text(
                    "project,bbsr",
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
