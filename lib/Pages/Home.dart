import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${widget.user.email}'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('users').document(widget.user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text('Loading');
            default:
              //return Text(snapshot.data['name']);
              return checkRole(snapshot.data);
          }
        },
      ),
    ) ;
  }
  
  Center checkRole(DocumentSnapshot snapshot){
    if(snapshot.data['role'] == 'admin'){
      return adminPage(snapshot);
    }else{
      return userPage(snapshot);
    }
  }
  
  Center adminPage(DocumentSnapshot snapshot){
    return Center(child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));
  }
  
  Center userPage(DocumentSnapshot snapshot){
    return Center(child: Text(snapshot.data['name']));
  }
}