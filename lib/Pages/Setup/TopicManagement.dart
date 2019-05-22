import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopicManagement{


  storeNewTopic(String type, String tab, String title, String content,context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userName = user.displayName;
    String photoUrl = user.photoUrl;
    String uid = user.uid;
    Timestamp time = Timestamp.now();
    Firestore.instance.collection(type).document('alltopic').collection(tab).add({
      'comment': 0,
      'content': content,
      'photoUrl': photoUrl,
      'time': time,
      'title' : title,
      'uid': uid,
      'username': userName,
      'view': 0
    }).then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/BottomNavigationBarPage');

    }).catchError((e){
      print(e);
    });
  }

  storeNewComment(String comment, String documentId, String tabText,context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userName = user.displayName;
    String photoUrl = user.photoUrl;
    String uid = user.uid;
    Timestamp time = Timestamp.now();
    Firestore.instance.collection('Topic').document('alltopic').collection(tabText)
        .document(documentId).collection('comments').add({
      'content': comment,
      'photoUrl': photoUrl,
      'time': time,
      'uid': uid,
      'username':userName
    }).then((value){
       var document = Firestore.instance.collection('Topic').document('alltopic').collection(tabText)
          .document(documentId);
      Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap = await transaction.get(document);
        await transaction.update(freshSnap.reference, {
          'comment': freshSnap['comment'] + 1
        });
      });
      Navigator.of(context).pop();
    }).catchError((e){
      print(e);
    });
  }

  storeNewQuestion(String type, String tab, String title, String content,context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userName = user.displayName;
    String photoUrl = user.photoUrl;
    String uid = user.uid;
    String gender = '';
    Timestamp time = Timestamp.now();
    QuerySnapshot snapshot = await Firestore.instance.collection('users').where('uid',isEqualTo: uid)
        .getDocuments();
    if(snapshot.documents.isNotEmpty){
      DocumentSnapshot documentSnapshot = snapshot.documents[0];
      gender = documentSnapshot['gender'];
    }
    Firestore.instance.collection(type).document('alltopic').collection(tab).add({
      'content': content,
      'photoUrl': photoUrl,
      'time': time,
      'gender': gender,
      'title' : title,
      'uid': uid,
      'username': userName,
      'status': '待解决'
    }).then((value){
      Navigator.of(context).pop();
      //Navigator.of(context).pushReplacementNamed('/BottomNavigationBarPage');

    }).catchError((e){
      print(e);
    });
  }
}