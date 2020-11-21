import 'dart:async';
import 'package:aplicacion_final/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'proyecto final',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Login()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 290,
            width: 360,
            color: Colors.orange,
            child: Image.asset("assets/rutheless logo.png"),

          ),
          Container(
            height: 290,
            width: 360,
            color: Colors.orange,
            child: Image.asset("assets/logo jovenes creativos.png"),

          ),
          Container(
            height: 60,
            width: 360,
            color: Colors.white,
            child: Image.asset("assets/sofka-logo-gradient-white.png"),
          )
        ],
      ),
    );
  }
}
