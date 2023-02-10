import 'package:flutter/material.dart';
import 'package:servicesandshop/homescreen/Categories/Categoriesmoniter.dart';
import 'package:servicesandshop/homescreen/Drawer/Sidedrawer.dart';
import 'package:servicesandshop/homescreen/Products/product.dart';

class Horizontallist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
      ),
      height: 132.0,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Categoriesource2(
                imgloc: 'assets/img/icon/Services.png',
                imgcat: 'Services',
                onpressed: () {
                  Navigator.pushNamed(
                    context,
                    Product.id,
                  );
                },
              ),
              Categoriesource2(
                imgloc: 'assets/img/icon/Sell.png',
                imgcat: 'Sell',
                onpressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        title: new Text(
                          "Warning",
                        ),
                        actions: <Widget>[
                          Center(
                            child: Image.asset(
                              "assets/img/warning.png",
                              width: 100.0,
                              height: 80.0,
                            ),
                          ),
                          Text(""),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "This page is comingsoon Sorry for inconvenience.",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.redAccent),
                            ),
                          ),
                          FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Categoriesource2(
                imgloc: 'assets/img/icon/Exchange.PNG',
                imgcat: 'Exchange',
                onpressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        title: new Text(
                          "Warning",
                        ),
                        actions: <Widget>[
                          Center(
                            child: Image.asset(
                              "assets/img/warning.png",
                              width: 100.0,
                              height: 80.0,
                            ),
                          ),
                          Text(""),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "This page is comingsoon Sorry for inconvenience.",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.redAccent),
                            ),
                          ),
                          FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>Sidedrawer ()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
