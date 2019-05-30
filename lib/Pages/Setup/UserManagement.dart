
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdc/Pages/MyInfo.dart';
import 'package:pdc/Pages/Setup/crud.dart';
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
     'intro' :'无',
   }).then((value){
     Navigator.of(context).pop();
     Navigator.of(context).pushReplacementNamed('/LoginPage');

   }).catchError((e){
     print(e);
   });
  }

  storeNewDoctor(user, context, String avatar,String gender, String speciality, String technicaltitle, String workField ){
    Firestore.instance.collection('users').add({
      'email': user.email,
      'displayName': user.displayName,
      'uid' : user.uid,
      'photoUrl': user.photoUrl,
      'gender': gender,
      'avatar': avatar,
      'intro' :'无',
      'speciality': speciality,
      'technicaltitle':technicaltitle,
      'workfield':workField
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

  followTopic(DocumentSnapshot snap, String tabText) async{
    FirebaseUser user = await CrudMethods().getUser();
    Firestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      DocumentSnapshot snapshot = docs.documents[0];
      //get the id of the current user in collection
      String currentId = snapshot.documentID;
      DocumentReference ref = Firestore.instance.document('Topic/alltopic/${tabText}/${snap.documentID}');
      Firestore.instance.collection('users').document(currentId).collection('Follow').add({
        'topicid': snap.documentID,
        'follow': true,
        'title': snap['title'],
        'content': snap['content'],
        'time' : snap['time'],
        'photoUrl': snap['photoUrl'],
        'uid': snap['uid'],
        'comment': snap['comment'],
        'view': snap['view'],
        'username': snap['username'],
        'tab': tabText,
        'reftopic': ref,
      });
    });
  }


  unFollowTopic(String documentId) async{
    FirebaseUser user = await CrudMethods().getUser();
    Firestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      DocumentSnapshot snapshot = docs.documents[0];
      //get the id of the current user in collection
      String currentId = snapshot.documentID;
      Firestore.instance.collection('users').document(currentId).collection('Follow')
          .where('topicid',isEqualTo: documentId).getDocuments().then((docs) {
            if(docs.documents.length == 0){
              return;
            }
            else{
              Firestore.instance.collection('users').document(currentId).collection('Follow')
                  .document(docs.documents[0].documentID).delete().catchError((e){
                print(e);
              });
              return;
            }

      }).catchError((e){
        print(e);
      });
    });
  }

  followDoctor( DocumentSnapshot doctorSnap) async{
    FirebaseUser user = await CrudMethods().getUser();
    Firestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      DocumentSnapshot snapshot = docs.documents[0];
      //get the id of the current user in collection
      String currentId = snapshot.documentID;
      DocumentReference ref = Firestore.instance.document('users/${doctorSnap.documentID}');
      Firestore.instance.collection('users').document(currentId).collection('Doctor').add({
        'refdoctor': ref,
        'uid': doctorSnap['uid'],
      });
    });
  }

  unFollowDoctor(DocumentSnapshot doctorSnap) async{
    FirebaseUser user = await CrudMethods().getUser();
    Firestore.instance.collection('users').where('uid',isEqualTo: user.uid).getDocuments().then((docs){
      DocumentSnapshot snapshot = docs.documents[0];
      //get the id of the current user in collection
      String currentId = snapshot.documentID;
      Firestore.instance.collection('users').document(currentId).collection('Doctor')
          .where('uid', isEqualTo: doctorSnap['uid']).getDocuments().then((doc){
            if(doc.documents.length == 0){
              return;
            }else{
              Firestore.instance.document('users/${currentId}/Doctor/${doc.documents[0].documentID}').delete();
              return;
            }

      });
    });
  }

  likeComment(DocumentSnapshot commentSnap){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).getDocuments()
          .then((userDoc){
         Firestore.instance.collection('users').document(userDoc.documents[0].documentID)
             .collection('Like').add({
           'reflike': commentSnap.reference
         });
      });
    });
  }

  unlikeComment(DocumentSnapshot commentSnap){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).getDocuments()
          .then((userDoc){
        Firestore.instance.collection('users').document(userDoc.documents[0].documentID)
            .collection('Like').where('reflike', isEqualTo: commentSnap.reference).getDocuments()
            .then((likeDoc){
           if(likeDoc.documents.length == 0){
             return;
           }else{
             Firestore.instance.document('users/${userDoc.documents[0].documentID}/Like/${likeDoc.documents[0].documentID}')
                 .delete();
             return;
           }
        });
      });
    });
  }

  updateProfilePic(picUrl) {
    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;
    FirebaseAuth.instance.currentUser().then((user){
      user.updateProfile(userInfo).then((val){
        Firestore.instance.collection('users').where('uid',isEqualTo: user.uid)
            .getDocuments().then((docs){
           Firestore.instance.document('users/${docs.documents[0].documentID}')
           .updateData({
             'photoUrl': picUrl
           });
        });
      });
    });

  }
}