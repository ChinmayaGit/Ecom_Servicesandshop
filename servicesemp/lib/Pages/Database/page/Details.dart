import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('Address').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("There is no expense");
          return ListView(children: getExpenseItems(snapshot));
        },
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map(
          (doc) => Card(
            elevation: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Details",style: TextStyle(
                  decoration: TextDecoration.underline,
                ),),
                subtitle: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Name : ', // default text style
                          children: <TextSpan>[
                            TextSpan(text: doc['name'], style: TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Address : ', // default text style
                          children: <TextSpan>[
                            TextSpan(text: doc['Address'], style: TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Phone No. : ', // default text style
                          children: <TextSpan>[
                            TextSpan(text: doc['Phone no.'], style: TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Products : ', // default text style
                          children: <TextSpan>[
                            TextSpan(text: doc['prodname'], style: TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Email : ', // default text style
                          children: <TextSpan>[
                            TextSpan(text: doc['email'], style: TextStyle(fontStyle: FontStyle.italic)),
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
