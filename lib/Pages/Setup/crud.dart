
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged{
    return _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);
  }

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
    FirebaseUser user  = await FirebaseAuth.instance.currentUser();
      return Firestore.instance.collection('users')
            .where('uid',isEqualTo: user.uid)
            .getDocuments();

    }

  getQues() async{
    FirebaseUser user  = await FirebaseAuth.instance.currentUser();
    QuerySnapshot snapshot = await Firestore.instance.collection('users')
        .where('uid',isEqualTo: user.uid)
        .getDocuments();
    return  Firestore.instance.collection('users').document(snapshot.documents[0].documentID)
        .collection('HistoryQuestion').getDocuments();
  }

  getRec() async{
    FirebaseUser user  = await FirebaseAuth.instance.currentUser();
    QuerySnapshot snapshot = await Firestore.instance.collection('users')
        .where('uid',isEqualTo: user.uid)
        .getDocuments();
    return  Firestore.instance.collection('users').document(snapshot.documents[0].documentID)
        .collection('HistoryTopic').getDocuments();

  }

    getFollow(String documentId) async{
      FirebaseUser user  = await FirebaseAuth.instance.currentUser();
       QuerySnapshot doc = await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).getDocuments();
       //print('1');
       return Firestore.instance.collection('users').document(doc.documents[0].documentID)
              .collection('Follow')
           .where('topicid',isEqualTo: documentId).getDocuments();


    }

  getFollowDoctor() async{
    FirebaseUser user  = await FirebaseAuth.instance.currentUser();
    QuerySnapshot doc = await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).getDocuments();
    return Firestore.instance.collection('users').document(doc.documents[0].documentID)
        .collection('Doctor').getDocuments();

  }

  String ReadableTime(String timestamp) {
    List<String> timeList = timestamp.split(" ");
    List<String> times = timeList[1].split(":");
    String time;
    if (new DateTime.now().toString().split(" ")[0] == timeList[0]) {
      if (int.parse(times[0]) < 6) {
        time = "凌晨${times[0]}:${times[1]}";
      } else if (int.parse(times[0]) < 12) {
        time = "上午${times[0]}:${times[1]}";
      } else if (int.parse(times[0]) == 12) {
        time = "中午${times[0]}:${times[1]}";
      } else {
        time =
        "下午${(int.parse(times[0])- 12).toString().padLeft(2,'0')}:${times[1]}";
      }
    } else {
      time = timeList[0];
    }
    return time;
  }

  DocumentSnapshot findTopic(DocumentSnapshot snap) {
    DocumentSnapshot documentSnapshot;
    Firestore.instance.collection('Topic').document('alltopic').collection(snap['tab']).getDocuments().then((doc){
      doc.documents.forEach((document){
        if(document.documentID == snap['topicid']){
          print('find');
          print(document);
          documentSnapshot = document;
          return documentSnapshot;
        }
      });
    });
    return documentSnapshot;
  }


  searchByName(String searchField) {
  return Firestore.instance
      .collection('Topic').document('alltopic').collection('外科')
      .where('searchKey',
  isEqualTo: searchField.substring(0, 1))
      .getDocuments();
  }


}