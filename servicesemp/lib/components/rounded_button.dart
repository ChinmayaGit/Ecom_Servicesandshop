import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({this.text,this.colour,@required this.onpressed
  });

  final Color colour;
  final Function onpressed;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: text,
        ),
      ),
    );
  }
}
