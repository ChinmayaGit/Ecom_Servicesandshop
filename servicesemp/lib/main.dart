import 'package:servicesemp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:servicesemp/Login/auth.dart';
import 'package:servicesemp/Login/auth_provider.dart';
import 'package:servicesemp/Login/root_page.dart';

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
          Homepage.id: (context)=>Homepage(),

        },
      ),
    );
  }
}

