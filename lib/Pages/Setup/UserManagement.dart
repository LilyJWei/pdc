
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdc/Pages/MyInfo.dart';
import 'package:pdc/Pages/Setup/signIn.dart';

class UserManagement {
  storeNewUser(user, context, String avatar,String gender){
   Firestore.instance.collection('users').add({
     'email': user.email,
     'displayName': user.displayName,
     'uid' : user.uid,
     'photoUrl': user.photoUrl,
     'gender': gender,
     'avatar': avatar,
   }).then((value){
     Navigator.of(context).pop();
     Navigator.of(context).pushReplacementNamed('/LoginPage');

   }).catchError((e){
     print(e);
   });
  }
  Widget handleAuth(){
    return new StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return MyInfoPage();
        }
        return LoginPage();
      },
    );
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }
}