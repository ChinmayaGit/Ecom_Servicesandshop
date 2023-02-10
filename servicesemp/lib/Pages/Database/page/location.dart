import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final key = new GlobalKey<ScaffoldState>();

class Location extends StatefulWidget {
  @override
  _PageeetState createState() => _PageeetState();
}

class _PageeetState extends State<Location> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: StreamBuilder(
        stream:
            Firestore.instance.collection('Location'.toString()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("There is no expense");
          return ListView(children: getExpenseItems(snapshot));
        },
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map(
          (doc) => Card(
            elevation: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  "Location",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                subtitle: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Text.rich(
                        TextSpan(
                          text: 'location:: ', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: doc['loc'],
                                style: TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                      onLongPress: () {
                        Clipboard.setData(new ClipboardData(
                          text: doc['loc'],
                        ));
                        key.currentState.showSnackBar(new SnackBar(
                          content: new Text("Copied to Clipboard"),
                        ));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Email : ', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: doc['email'],
                                style: TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
