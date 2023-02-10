import 'package:flutter/material.dart';
import 'package:servicesandshop/homescreen/Pages/pageone.dart';

class Product extends StatefulWidget {
  static const String id = 'Product';
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var productlist = [
    {
      "name": "Air Conditioner",
      "picture": "assets/img/services/Airconditioner.png",
    },
    {
      "name": "Automatic pump controller",
      "picture": "assets/img/services/Automaticpumpcontroller.jpg",
    },
    {
      "name": "Water Cooler",
      "picture": "assets/img/services/bluestarwatercooler.jpg",
    },
    {
      "name": "Ceiling Fan",
      "picture": "assets/img/services/Cellingfan.jpg",
    },
    {
      "name": "Chimney",
      "picture": "assets/img/services/Chimney.jpg",
    },
    {
      "name": "Deep Fridge",
      "picture": "assets/img/services/Deepfridge.jpg",
    },
    {
      "name": "Fridge",
      "picture": "assets/img/services/Fridge.jpg",
    },
    {
      "name": "Gas Stove",
      "picture": "assets/img/services/Gasstove.jpg",
    },
    {
      "name": "Geyser",
      "picture": "assets/img/services/Geyser.jpg",
    },
    {
      "name": "Grinder",
      "picture": "assets/img/services/Grinder.jpg",
    },
    {
      "name": "Induction",
      "picture": "assets/img/services/Induction.jpg",
    },
    {
      "name": "Inva Tubular Battery",
      "picture": "assets/img/services/Invatubularbattery.jpg",
    },
    {
      "name": "Inverter",
      "picture": "assets/img/services/Inverter.jpg",
    },
    {
      "name": "Solar Inverter",
      "picture": "assets/img/services/Solarinverter.jpg",
    },
    {
      "name": "Stabilizer",
      "picture": "assets/img/services/Stabilizer.jpg",
    },
    {
      "name": "Stand Fan",
      "picture": "assets/img/services/Standfan.jpg",
    },
    {
      "name": "Table fan",
      "picture": "assets/img/services/Tablefan.jpg",
    },
    {
      "name": "Washing Machine",
      "picture": "assets/img/services/Washingmachine.jpg",
    },
    {
      "name": "Water Dispenser",
      "picture": "assets/img/services/Waterdispenser.jpg",
    },
    {
      "name": "Water purifier",
      "picture": "assets/img/services/Waterpurifier.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView.builder(
            itemCount: productlist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 2),
            itemBuilder: (BuildContext context, int index) {
              return Singleprod(
                prodname: productlist[index]['name'],
                prodpic: productlist[index]['picture'],
                prodprice: productlist[index]['price'],
                prodoldprice: productlist[index]['oldprice'],
              );
            }),
      ),
    );
  }
}

class Singleprod extends StatelessWidget {
  Singleprod({
    @required this.prodname,
    @required this.prodoldprice,
    @required this.prodpic,
    @required this.prodprice,
  });

  final prodname;
  final prodpic;
  final prodoldprice;
  final prodprice;

  @override
  Widget build(BuildContext context) {
    return
        Card(
          child: Hero(
              tag: prodname,
              child: Material(
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Pageone(
                        productdetailsname: prodname,
                        productdetailspicture: prodpic,
                        productdetailsoldprice: prodoldprice,
                        productdetailsprice: prodprice,

                      );
                    }),

                  ),

                  child: GridTile(
                      footer: Container(

                        child: ListTile(
                          leading: Text(
                            prodname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '\$$prodoldprice',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          title: Text(
                            '\$$prodprice',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      child: Image.asset(
                        prodpic,
                        fit: BoxFit.contain,
                      )),
                ),
              )),
    );
  }
}
