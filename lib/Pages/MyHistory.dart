import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';
import 'package:pdc/Pages/QuestionDetailDoctor.dart';
import 'package:pdc/Pages/Setup/crud.dart';
import 'package:pdc/Pages/TopicDetail.dart';

class MyHistoryPage extends StatefulWidget {
  @override
  _MyHistoryPageState createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {

  final List<Tab> tabs = <Tab>[
    new Tab(text: "帖子"),
    new Tab(text: "问题"),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
              onPressed: (){
                Navigator.of(context).pop();
              }
          ) ,
          title: Text('我的历史记录', textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 69, 69, 92)),),
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
              return FutureBuilder(
                  future: tab.text == '帖子'?
                  Firestore.instance.collection('users').document(docId).collection('HistoryTopic').
                  orderBy('time',descending: true).getDocuments()
                      :Firestore.instance.collection('users').document(docId).collection('HistoryQuestion')
                      .orderBy('time',descending: true).getDocuments(),
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
                              List path = ref.path.split('/');
                              String tabText = path[2];

                              return StreamBuilder(
                                stream:  ref.snapshots(),
                                builder: (BuildContext context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text('Loading');
                                  } else {
                                    DocumentSnapshot document = snapshot.data;
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
                              DocumentReference ref = snap['refquestion'];
                              String path = ref.path;
                              List split = path.split('/');
                              String splitPath = split[2];
                              return StreamBuilder(
                                  stream: ref.snapshots(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData){
                                      return Center(
                                        child: Text('Loading...'),
                                      );
                                    }
                                    else{
                                      DocumentSnapshot snap = snapshot.data;
                                      return new Container(
                                          height: 50,
                                          margin: EdgeInsets.only(left: 0),
                                          child: question(context, index, snap, splitPath)
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
  Widget question(BuildContext context, int index, DocumentSnapshot document, String tabText){
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 18),
            height: 50,
            child: FlatButton(
              padding: EdgeInsets.only(left: 0),
              onPressed: (){
                Firestore.instance.collection('users').document(docId).collection('HistoryQuestion')
                    .where('refquestion',isEqualTo: document.reference).getDocuments().then((refDoc){
                  if(refDoc.documents.length == 0){
                    Firestore.instance.collection('users/${docId}/HistoryQuestion').add({
                      'refquestion': document.reference,
                      'time': Timestamp.now(),
                    });
                  }
                  else{
                    DocumentSnapshot snap = refDoc.documents[0];
                    Firestore.instance.runTransaction((transaction) async {
                      DocumentSnapshot freshSnap = await transaction.get(snap.reference);
                      await transaction.update(freshSnap.reference, {
                        'time': Timestamp.now(),
                      });
                    });
                  }
                });
                FirebaseAuth.instance.currentUser().then((user){
                  Firestore.instance.collection('users').where('uid',isEqualTo: user.uid)
                      .getDocuments().then((doc){
                    DocumentSnapshot snap = doc.documents[0];
                    if(snap['avatar'] == 'doctor'){
                      Navigator.of(context).push(MaterialPageRoute
                        (builder: (context) => QuestionDetailDoctorPage(snap: document, tabs: tabText))) ;
                    }else{
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => QuestionDetailPage(snap: document, tabs: tabText)));

                    }
                  });
                });

                //Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailPage()));
              },
              child: new Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text( document['title'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(document['status'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(CrudMethods().ReadableTime(document['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14,
                        fontWeight: FontWeight.w300
                    )),
                  )
                ],
              ),
            )

        )
      ],
    );
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => TopicDetailPage(snap: currentDoc, tabs: tabText,)));
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap = await transaction.get(currentDoc.reference);
                await transaction.update(freshSnap.reference, {
                  'view': freshSnap['view'] + 1
                });
              });
              Firestore.instance.collection('users').document(docId).collection('HistoryTopic')
                  .where('reftopic',isEqualTo: currentDoc.reference).getDocuments().then((refDoc){
                if(refDoc.documents.length == 0){
                  Firestore.instance.collection('users/${docId}/HistoryTopic').add({
                    'reftopic': currentDoc.reference,
                    'time' : Timestamp.now(),
                  });
                }
                else{
                  DocumentSnapshot snap = refDoc.documents[0];
                  Firestore.instance.runTransaction((transaction) async {
                    DocumentSnapshot freshSnap = await transaction.get(snap.reference);
                    await transaction.update(freshSnap.reference, {
                      'time': Timestamp.now(),
                    });
                  });
                }
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
}
