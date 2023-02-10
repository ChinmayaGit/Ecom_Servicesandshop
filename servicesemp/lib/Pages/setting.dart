import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
final key = new GlobalKey<ScaffoldState>();
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: key,

      body: Center(
        child: GestureDetector(
          child: Text.rich(
            TextSpan(
              text: 'WEB: ', // default text style
              children: <TextSpan>[
                TextSpan(
                    text: "http://geohash.co/",
                    style: TextStyle(fontStyle: FontStyle.italic,fontSize: 30)),
              ],
            ),
          ),
          onLongPress: () {
            Clipboard.setData(new ClipboardData(
              text: "http://geohash.co/",
            ));
            key.currentState.showSnackBar(new SnackBar(
              content: new Text("Copied to Clipboard"),
            ));
          },
        ),
      ),
    );
  }

}
