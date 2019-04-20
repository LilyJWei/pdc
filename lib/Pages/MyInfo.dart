import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyInfo'),
        backgroundColor: Color.fromARGB(255, 240, 123, 135),
      ),
    );
  }
}
