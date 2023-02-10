import 'package:flutter/material.dart';
import 'package:servicesandshop/Login/auth.dart';
import 'package:servicesandshop/Login/auth_provider.dart';
import 'package:servicesandshop/Login/root_page.dart';
import 'package:servicesandshop/homescreen/Pages/home_page.dart';
import 'package:servicesandshop/homescreen/Products/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter login demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RootPage.id,
        routes: {
          RootPage.id: (context) => RootPage(),
          Homepage.id: (context) => Homepage(),
          Product.id: (context) => Product(),
        },
      ),
    );
  }
}
