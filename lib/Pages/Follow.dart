import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdc/Pages/DoctorDetail.dart';
import 'package:pdc/Pages/Setup/crud.dart';
import 'package:pdc/Pages/TopicDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {

  final List<Tab> tabs = <Tab>[
    new Tab(text: "帖子"),
    new Tab(text: "医生"),
  ];
  String userId;
  String docId;
  @override
  void initState() {
    super.initState();
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
  }

  Widget topic(BuildContext context, int index, DocumentSnapshot currentDoc, String tabText){
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 4,
            child:Text(currentDoc['title'],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92)),
              maxLines: 1,
            )),
        Expanded(
            flex: 10,
            child:FlatButton(onPressed: (){
              print(currentDoc.documentID);
              Navigator.push(context, MaterialPageRoute(builder: (context) => TopicDetailPage(snap: currentDoc, tabs: tabText,)));
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap = await transaction.get(currentDoc.reference);
                await transaction.update(freshSnap.reference, {
                  'view': freshSnap['view'] + 1
                });
              });
              },
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  currentDoc['content'],
                  style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 101, 104, 127)),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ))
        ),
        Expanded(
            flex: 0,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(currentDoc['photoUrl']),
                      radius: 17.0,
                    )
                ),
                Expanded(
                    flex: 5,
                    child: Text( currentDoc['username'], style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13),)
                ),
                Expanded(
                    flex: 6,
                    child: Text(CrudMethods().ReadableTime(currentDoc['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                ),
                Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.comment,
                        size: 16,
                        color: Colors.black26,
                      ),
                    )

                ),
                Expanded(
                    flex: 2,
                    child: Text(currentDoc['comment'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                ),
                Expanded(
                    flex: 2,
                    child:  Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Colors.black26,
                    )
                ),
                Expanded(
                    flex: 2,
                    child: Text(currentDoc['view'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                ),

              ],
            )
        ),
        Divider(
          color: Colors.black26,
        )
      ],
    );
  }

  Widget doctor(BuildContext context, int index, DocumentSnapshot snap) {
    return new Row(
      children: <Widget>[
        Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(snap['photoUrl']),
            radius: 20,
          ),

        ),
        FlatButton(
          child: Container(
            margin: EdgeInsets.only(left: 21),
            width: 250,
            child: Text(
              snap['displayName'],
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92) ),
            ),
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorDetailPage(doctorSnap: snap,)));
          },
        ),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('我的关注', textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 69, 69, 92)),),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 3.5, color: Color.fromARGB(255, 240, 123, 135))),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs,
            labelColor: Color.fromARGB(255, 69, 69, 92),
            unselectedLabelColor: Color.fromARGB(255, 145, 153, 185),
          ),

        ),
        body: new TabBarView(
           children: tabs.map((Tab tab){
                 return StreamBuilder(
                   //stream: tab.text == '医生'? CrudMethods().getAllFollow(userId): CrudMethods().getAllFollow(userId),
                   stream: tab.text == '医生'? Firestore.instance.collection('users').document(docId).collection('Doctor').snapshots()
                       :Firestore.instance.collection('users').document(docId).collection('Follow').snapshots(),
                     builder: (context, snapshot) {
                     if(!snapshot.hasData){
                       return Text('Loading...');
                     }else{
                       //print(snapshot.data.documents.length);
                       return new ListView.builder(
                           itemCount: snapshot.data.documents.length,
                           itemBuilder: (BuildContext context, int index) {
                             DocumentSnapshot snap = snapshot.data
                                 .documents[index];
                             if (tab.text == '帖子') {
                               DocumentReference ref = snap['reftopic'];
                               //print(ref);
                               String id = ref.documentID;
                               //print(id);
                               return StreamBuilder(
                                 stream:  Firestore.instance.collection('Topic')
                                     .document('alltopic').collection(
                                     snap['tab'])
                                     .document(id)
                                     .snapshots(),
                                 builder: (BuildContext context, snapshot) {
                                   if (!snapshot.hasData) {
                                     return Text('Loading');
                                   } else {
                                     DocumentSnapshot document = snapshot.data;
                                     String tabText = snap['tab'];
                                     return new Container(
                                       height: 160,
                                       margin: EdgeInsets.only(left: 18),
                                       child: topic(
                                           context, index, document, tabText),
                                     );
                                   }
                                 },
                               );
                             } else {
                               String path = snap['refdoctor'].path;
                               List split = path.split('/');
                               String splitPath = split[1];
                               return StreamBuilder(
                                 stream: Firestore.instance.collection('users').document(splitPath).snapshots(),
                                 builder: (context, snapshot) {
                                   if(!snapshot.hasData){
                                     return Center(
                                       child: Text('Loading...'),
                                     );
                                   }
                                   else{
                                     DocumentSnapshot snap = snapshot.data;
                                     return new Container(
                                         height: 80,
                                         margin: EdgeInsets.only(left: 18),
                                         child: doctor(context, index, snap)
                                     );
                                   }

                                 }
                               );

                             }
                           });
                     }

                   }
                 );
               }
           ).toList()
        ),
      ),

    );
  }
}


