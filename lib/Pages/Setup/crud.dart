
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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



}