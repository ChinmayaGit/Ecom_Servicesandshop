import 'package:flutter/material.dart';

class Categoriesource1 extends StatelessWidget {
  Categoriesource1({@required this.imgloc, @required this.imgcat});

  final String imgloc;
  final String imgcat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(

          width: 135.0,
          child: ListTile(
            title: Image.asset(
              imgloc,
              width: 100.0,
              height: 100.0,
            ),
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  imgcat,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ),
    );
  }
}

class Categoriesource2 extends StatelessWidget {
  Categoriesource2({@required this.imgloc, @required this.imgcat, this.onpressed,});
  final String imgloc;
  final String imgcat;
  final Function onpressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onpressed,
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              imgloc,
              width: 100.0,
              height: 110.0,
            ),
            subtitle: Material(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    imgcat,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black38),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

//icon widget to insert icon in categories list
class Iconss extends StatelessWidget {
  Iconss({
    @required this.img,
  });
  final Icon img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: img,
    );
  }
}
