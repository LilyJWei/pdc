

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';
import 'package:pdc/Pages/QuestionDetailDoctor.dart';
import 'package:pdc/Pages/Setup/crud.dart';

class MyQuestionPage extends StatefulWidget {
  @override
  _MyQuestionPageState createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  String docId;
  String userId;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
      userId = user.uid;
      Firestore.instance.collection('users').where('uid', isEqualTo: userId)
          .getDocuments().then((docs){
        setState(() {
          docId = docs.documents[0].documentID;
        });
      });
    }).catchError((e){
      print(e);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ) ,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('我的问题',style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 18),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 18),
                  height: 23,
                  color: Color.fromARGB(255, 246, 241, 241),
                  child: new Row(
                    children: <Widget>[
                      Expanded(flex: 4,
                          child: Text('提问标题', style: TextStyle(
                              color: Color.fromARGB(255, 145, 153, 185),
                              fontSize: 14),)),
                      Expanded(flex: 2,
                          child: Text('状态', style: TextStyle(
                              color: Color.fromARGB(255, 145, 153, 185),
                              fontSize: 14),)),
                      Expanded(flex: 2,
                          child: Text('日期', style: TextStyle(
                              color: Color.fromARGB(255, 145, 153, 185),
                              fontSize: 14),)),

                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  )
              )),
          Expanded(
            flex: 25,
            child: StreamBuilder(
                      stream: Firestore.instance.collection('users').document(docId)
                          .collection('Question').snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return const Text('Loading....');
                        }else{
                          return new ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot document = snapshot.data.documents[index];
                                DocumentReference ref = document['refquestion'];
                                return StreamBuilder(
                                  stream: ref.snapshots(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData){
                                      return Text('Loading...');
                                    }
                                    else{
                                      DocumentSnapshot snapQuestion = snapshot.data;
                                      List tabs = ref.path.split('/');
                                      String tab = tabs[2];
                                      return new Container(
                                          padding: EdgeInsets.only(left: 18),
                                          height: 50,
                                          child: FlatButton(
                                            padding: EdgeInsets.only(left: 0),
                                            onPressed: (){
                                                Firestore.instance.collection('users').where('uid',isEqualTo: userId)
                                                    .getDocuments().then((doc){
                                                  DocumentSnapshot snap = doc.documents[0];
                                                  if(snap['avatar'] == 'doctor'){
                                                    Navigator.of(context).push(MaterialPageRoute
                                                      (builder: (context) => QuestionDetailDoctorPage(snap: snapQuestion, tabs: tab))) ;
                                                  }else{
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (context) => QuestionDetailPage(snap: snapQuestion, tabs: tab))) ;
                                                  }
                                                });


                                              //Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailPage()));
                                            },
                                            child: new Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 4,
                                                  child: Text( snapQuestion['title'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(snapQuestion['status'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(CrudMethods().ReadableTime(snapQuestion['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14,
                                                      fontWeight: FontWeight.w300
                                                  )),
                                                )
                                              ],
                                            ),
                                          )

                                      );
                                    }

                                  }
                                );
                              });
                        }

                      }

            ))

        ],
      ),

    );
  }
}
