
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdc/Pages/MyInfo.dart';
import 'package:pdc/Pages/Setup/signIn.dart';

class CrudMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> getUser() async{
      return await FirebaseAuth.instance.currentUser();
}
    getData() async{
//    return FirebaseAuth.instance.currentUser().then((user){
//      Firestore.instance.collection('users')
//          .where('uid',isEqualTo: user.uid)
//          .getDocuments();
//      });
    FirebaseUser user  = await FirebaseAuth.instance.currentUser();
      return Firestore.instance.collection('users')
            .where('uid',isEqualTo: user.uid)
            .getDocuments();

    }

   testgetData(String name) {
    return Firestore.instance.collection('users')
          .where('displayName',isEqualTo: name)
          .getDocuments();

  }



}