import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/Setup/crud.dart';
import 'package:pdc/Pages/TopicDetail.dart';

class MyLikePage extends StatefulWidget {
  @override
  _MyLikePageState createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
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
        title: Text('我的赞',style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 18),),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('users').document(docId).collection('Like')
              .snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Text('Loading....'),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index){
                  DocumentSnapshot refSnap = snapshot.data.documents[index];
                  DocumentReference reference = refSnap['reflike'];
                  List path = reference.path.split('comments');
                  List tab = reference.path.split('/');
                  String splitTab = tab[2];
                  String splitPath = path[0];

                  return StreamBuilder(
                      stream: reference.snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Center(
                            child: Text('Loading....'),
                          );
                        }else{
                          DocumentSnapshot commentSnap = snapshot.data;
                          return Container(
                            margin: EdgeInsets.only(top: 5,left: 20,right: 20,bottom: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //the first line, photoUrl and username
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 2, left: 0,right: 10,bottom: 2),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(commentSnap['photoUrl']),
                                          radius: 20.0,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 2, left: 10,right: 10,bottom: 2),
                                        child: Text(commentSnap['username'], style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),
                                            fontSize: 18),),
                                      )
                                    ],
                                  ),
                                ),
                                //the second line,time of the comment
                                Container(
                                  margin: EdgeInsets.only(top: 0, left: 40,right: 10,bottom: 2),
                                  child: Text(CrudMethods().ReadableTime(commentSnap['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),
                                      fontSize: 13),),
                                ),
                                //the third line, comment content
                                Container(
                                  margin: EdgeInsets.only(top: 5, left: 0,right: 10,bottom: 5),
                                  child: Text(commentSnap['content'], style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),
                                      fontSize: 16),),
                                ),
                                //the forth line, the title of topic
                                StreamBuilder(
                                    stream: Firestore.instance.document(splitPath).snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: Text('Loading....'),
                                        );
                                      }else{
                                        DocumentSnapshot topicSnap = snapshot.data;
                                        return FlatButton(
                                          padding: EdgeInsets.all(0),
                                          child: Container(
                                            padding: EdgeInsets.all(0),
                                            margin: EdgeInsets.only(top: 10, left: 0,right: 10,bottom: 2),
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                //topic title
                                                Container(
                                                  margin:EdgeInsets.only(left: 10,right: 20,top: 0, bottom: 0),
                                                  child: Text(topicSnap['title'],style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 18
                                                      ,fontWeight: FontWeight.w400),),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    //user photo
                                                    Container(
                                                      margin: EdgeInsets.only(top: 5, bottom: 2, left: 0,right: 10),
                                                      child: CircleAvatar(
                                                        backgroundImage:NetworkImage(topicSnap['photoUrl']),
                                                        radius: 13.0,
                                                      ),
                                                    ),
                                                    //userName
                                                    Container(
                                                      margin: EdgeInsets.only(top: 5, bottom: 2, left: 0,right: 10),
                                                      child: Text(topicSnap['username'],style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 14,
                                                          fontWeight: FontWeight.w300),),
                                                    ),
                                                    //time
                                                    Container(
                                                      margin: EdgeInsets.only(top: 5, bottom: 2, left: 20, right: 10),
                                                      child: Text(CrudMethods().ReadableTime(topicSnap['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 14,
                                                          fontWeight: FontWeight.w300)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)
                                            => TopicDetailPage(snap: topicSnap, tabs: splitTab,)));

                                          },
                                        );
                                      }

                                    }
                                ),
                                Divider(
                                  color: Colors.black26,
                                )
                              ],
                            ),

                          );
                        }

                      }
                  );
                },
              );
            }
          }
      ),
    );
  }
}
