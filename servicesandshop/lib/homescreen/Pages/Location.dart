import 'package:android_intent/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Geoflutterfire geo = Geoflutterfire();

//
class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

class MyMapSampleState extends State<MyMap> {
  GoogleMapController _controller;
  Position position;
  Widget _child;
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    initUser();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }
  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Send us your location",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: <Widget>[

          Container(
            color: Colors.red,
            child: Row(
              children: <Widget>[
                Text("  Help"),
                IconButton(
                  icon: Icon(Icons.info_outline, color: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: new Text(
                            "Please press the button if you are facing any problem to get your location",
                          ),
                          actions: <Widget>[
                            FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text('LOCATION'),
                                color: Colors.indigoAccent,
                                textColor: Colors.white,
                                onPressed: () {
                                  openLocationSetting();
                                  Navigator.of(context).pop();
                                }),
                          ],
                        );
                      },
                    );
                  },
                ),

              ],
            ),
          ),
//
        ],
      ),
      body: _child,
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("home"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: "home",
        ),
      )
    ].toSet();
  }

  Widget mapWidget() {
    return Stack(children: [
      GoogleMap(
          mapType: MapType.normal,
          markers: _createMarker(),
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 11,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          }),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    title: new Text(
                      "Location Share",
                    ),
                    actions: <Widget>[
                      Center(
                        child: Image.asset(
                          "assets/img/registrationsuccessful.png",
                          width: 100.0,
                          height: 80.0,
                        ),
                      ),
                      Text(""),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Thanks for sharing your location we will ba at you door soon.",
                          style: TextStyle(fontSize: 25),
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
              GeoFirePoint point = geo.point(
                  latitude: position.latitude, longitude: position.longitude);
              return Firestore.instance.collection('Location').add(
                {
                  'loc': point.hash,
                  'time': DateTime.now(),
                  "email": this.user.email,
                },
              );
            },
            icon: Icon(Icons.add_location, color: Colors.red),
            label: Text("Share location"),
          ),
        ],
      ),
    ]);
  }
}
