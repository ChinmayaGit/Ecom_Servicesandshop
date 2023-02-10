import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController username = new TextEditingController();
  TextEditingController birthday = new TextEditingController();

  bool checkValue = false;

  SharedPreferences sharedPreferences;
  File _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    initUser();
    getCredential();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Edit Profile'),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.black,
                          child: ClipOval(
                            child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image != null)
                                  ? Image.file(
                                _image,
                                fit: BoxFit.fill,
                              )
                                  : Image.network(
                                "https://cdn3.iconfinder.com/data/icons/login-6/512/LOGIN-10-512.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Email',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${user.email}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'Username',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '     ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(

                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: username,
                          decoration: InputDecoration(
                            hintStyle: new TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'Birthday',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '     ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child:  Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: birthday,
                          decoration: InputDecoration(
                            hintStyle: new TextStyle(

                              color: Colors.black,
                              fontSize: 20.0,
                            ),),
                        ),
                      ),

                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                CheckboxListTile(
                  value: checkValue,
                  onChanged: _onChanged,
                  title: new Text("Remember me"),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),

                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {
                        uploadPic(context);

                      },
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),

                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("birthday", birthday.text);
      sharedPreferences.commit();
      getCredential();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username");
          birthday.text = sharedPreferences.getString("birthday");
        } else {
          username.clear();
          birthday.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

}
