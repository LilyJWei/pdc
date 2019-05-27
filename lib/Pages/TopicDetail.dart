import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/Comment.dart';
import 'package:pdc/Pages/Setup/UserManagement.dart';
import 'package:pdc/Pages/Setup/crud.dart';

class TopicDetailPage extends StatefulWidget {
  const TopicDetailPage({Key key, this.snap, this.tabs}) : super(key: key);
  final DocumentSnapshot snap;
  final String tabs;
  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {

  bool _isFollow;
  String docId;
  String userId;

  @override
  void initState() {
    _isFollow = false;
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
    String tabText = widget.tabs;
    DocumentSnapshot snap = widget.snap;
    String docid = snap.documentID;
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body: FutureBuilder(
                future:  Firestore.instance.collection('Topic').document('alltopic').collection(tabText)
                              .document(widget.snap.documentID).collection('comments').orderBy('time').getDocuments(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return const Text("Loading....");
                  }else{
                    int length = snapshot.data.documents.length;
                    return Container(
                      child: ListView.builder(
                        itemExtent: 200,
                        itemCount: length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document;
                          if(index >= 1){
                            document = snapshot.data.documents[ index - 1];
                          }
                          else{
                            document = null;
                          }
                          bool isLike = false;
                          return new Container(
                            color: Colors.white,
                            height: 170,
                            margin: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            flex:1,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                                                  child: CircleAvatar(
                                                    backgroundImage: index == 0? NetworkImage(snap['photoUrl'])
                                                    : NetworkImage(document['photoUrl']),
                                                    radius: 15,
                                                  ),
                                                ),

                                                Expanded(
                                                  flex: 3,
                                                  child: index == 0 ? Text(snap['username'], style: TextStyle(color: Color.fromARGB(255,3,121,251),fontSize: 12),)
                                                      : Text(document['username'], style: TextStyle(color: Color.fromARGB(255,3,121,251),fontSize: 12),),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child:
                                                  index == 0? Text('楼主', style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 12),)
                                                      : Text(index.toString() + '楼',style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 12) ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 50,right: 20),
                                                child: index == 0 ? Text(snap['content'],
                                                  style:  TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 14 ),):
                                                Text(document['content'],
                                                  style:  TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 14 ),),
                                              )
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child:Container(
                                                margin: EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 15,
                                                      child: index == 0? Text(CrudMethods().ReadableTime(snap['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),):
                                                      Text(CrudMethods().ReadableTime(document['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),),
                                                    ),
                                                    Expanded(
                                                      flex: 0,
                                                      child: index > 0 ? Text('赞',style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10)):
                                                      Text(' '),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: index > 0? IconButton(icon: Icon(Icons.thumb_up), iconSize: 15,
                                                          color: _likeIconColor(index, isLike),
                                                          onPressed: (){
                                                           Firestore.instance.runTransaction((transaction) async {
                                                             DocumentSnapshot freshSnap = await transaction.get(document.reference);
                                                             if(document['like'] == true){
                                                               await transaction.update(freshSnap.reference, {
                                                                 'like': false
                                                               });
                                                             }else{
                                                               await transaction.update(freshSnap.reference, {
                                                                 'like': true
                                                               });
                                                             }

                                                           });

                                                      }): Text(" ")
                                                    )
                                                  ],
                                                ),
                                              )

                                          )
                                        ],
                                      ),
                                    )

                                ),
                              ],
                            ),

                          );
                        },

                      ),
                    );
                  }
                }

              ),
      ),
       bottomNavigationBar:BottomAppBar(
         child: Container(
           margin: EdgeInsets.all(0),
           padding: EdgeInsets.all(0),
           height: 50,
           child: Row(
             children: <Widget>[
               Expanded(
                 flex: 7,
                   child: FlatButton(
                     padding: EdgeInsets.all(0),
                     child: Text(
                       "想对Ta说点什么...",
                       style: TextStyle(color: Color.fromARGB(255, 215, 212, 212), fontSize: 12),
                       textAlign: TextAlign.start,
                     ),
                     onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(tab: tabText, id: docid)));
                     },
                   )
                   
               ),
               StreamBuilder(
                   stream: Firestore.instance.collection('users').document(docId)
                       .collection('Follow').where('topicid',isEqualTo:widget.snap.documentID).snapshots(),
                   builder: (context, snapshot){
                         if(!snapshot.hasData){
                           return Text('Loading');
                         }else{
                           if(snapshot.data.documents.length == 0){
                             _isFollow = false;
                           }else {
                             _isFollow = true;
                           }
                         }
                         return Expanded(
                             flex: 3,
                             child: _isFollow? IconButton(
                               icon: Icon(Icons.favorite,color: Color.fromARGB(255, 240, 123, 135),),
                               onPressed:() {
                                 UserManagement().unFollowTopic(snap.documentID);
                                 setState(() {
                                   _isFollow = false;
                                 });
                               },
                             ):IconButton(
                               icon: Icon(Icons.favorite_border,color: Colors.black26,),
                               onPressed:() {
                                 UserManagement().followTopic(snap, tabText);
                                 setState(() {
                                   _isFollow = true;
                                 });
                               },
                             )

                         );



                   }

               )
             ],
           ),
         ),
       )
    );
  }



  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled){
    return <Widget>[
      SliverAppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ) ,
        title: Text(widget.snap.data['title'] ,style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontWeight: FontWeight.w500),),
        pinned: true,
        backgroundColor: Colors.white,
        elevation: 1,

      )

    ];
  }
  Color _likeIconColor(int index, bool isLike){
      if(isLike == false){
        return Colors.black26;
      }else{
        return Color.fromARGB(255, 240, 123, 135);
      }
    }


}
