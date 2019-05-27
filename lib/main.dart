import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/BottomNavigationBar.dart';
import 'package:pdc/Pages/MainPage.dart';
import 'package:pdc/Pages/Setup/SignUp.dart';
import 'package:pdc/Pages/Setup/signIn.dart';
import 'Pages/Setup/Welcome.dart';


void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      //home: BottomNavigationBarPage(),
      home: LoginPage(),
      //home: SignUpPage(),
      //home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        '/BottomNavigationBarPage': (BuildContext context) => new BottomNavigationBarPage(),
        '/LoginPage':(BuildContext context) => new LoginPage()
      },
    );
  }
}