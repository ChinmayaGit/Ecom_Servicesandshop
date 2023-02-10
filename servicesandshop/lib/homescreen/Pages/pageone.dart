import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servicesandshop/homescreen/Pages/Location.dart';

class Pageone extends StatefulWidget {
  Pageone({
    this.productdetailsname,
    this.productdetailsprice,
    this.productdetailsoldprice,
    this.productdetailspicture,
    this.prolocation,
  });

  final productdetailsname;
  final productdetailsprice;
  final productdetailsoldprice;
  final productdetailspicture;
  final prolocation;

  @override
  _PageoneState createState() => _PageoneState();
}

class _PageoneState extends State<Pageone> {
  GlobalKey<FormState> _key = new GlobalKey();

  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  FirebaseUser user;

  String address;
  String number;
  String name;
  String problem;
  bool _validate = false;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.productdetailsname,
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productdetailspicture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productdetailsname,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '\$${widget.productdetailsoldprice}',
                          style: TextStyle(
                              color: Colors.redAccent,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '\$${widget.productdetailsprice}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                autovalidate: _validate,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                      InputDecoration(hintText: 'Enter your Full Name'),
                      maxLength: 32,
                      validator: validateName,
                      onChanged: (value) {
                        this.name = value;
                      },
                    ),
                    TextFormField(
                        validator: validateMobile,
                        maxLengthEnforced: true,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter your Phone Number'),
                        onChanged: (value) {
                          this.number = value;
                        }),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            validator: validateother,
                            decoration: InputDecoration(
                              hintText: 'Enter your Full Address or press =>',
                            ),
                            maxLength: 32,
                            onChanged: (value) {
                              this.address = value;
                            },
                          ),
                        ),
                        Container(
                          width: 50,
                          child: FlatButton(
                            child: Icon(
                              Icons.my_location,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyMap()));
                              Fluttertoast.showToast(
                                msg:
                                    "Please turn on you location if Map not showing",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'write here if any specific problem'),
                      onChanged: (value) {
                        this.problem = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text('Add'),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        _sendToServer();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Center(
              child: Text(
            "We provide services for all kind of electronic things",
            style: TextStyle(fontSize: 15),
          )),
          SizedBox(
            height: 8.0,
          ),
          Center(child: Text("contact no.9776790204")),
          SizedBox(
            height: 8.0,
          ),
          Center(
              child: Text(
                  "Plot No-200/1295,kalinga nagar,inforent of tata ariana ")),
          Center(child: Text("project,bbsr")),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateother(String value) {
    String pattern = r'^[a-zA-Z0-9-/.]+$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Address is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Address";
    } else {
      return null;
    }
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      _firestore
          .collection('Address')
          .add({
            'name': this.name,
            'Phone no.': this.number,
            'Address': this.address,
            'prodname': this.widget.productdetailsname,
            'time': DateTime.now(),
            "problem": this.problem,
            "email": this.user.email,
          })
          .then((result) {})
          .catchError((e) {
            print(e);
          });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Colors.black,
            title: new Text(
              "Registration successful",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
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
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
