import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/SearchBar.dart';
import 'package:pdc/Pages/Setup/Recommend.dart';
import 'package:pdc/Pages/Setup/Recommend.dart' as prefix0;
import 'package:pdc/Pages/Setup/crud.dart';
import 'package:pdc/Pages/Setup/signIn.dart';
import 'package:pdc/Pages/TopicDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin{
 final List<Tab> tabs = <Tab>[
   new Tab(text: "推荐"),
   new Tab(text: "内科"),
   new Tab(text: "外科"),
   new Tab(text: "五官科"),
   new Tab(text: "儿科"),
   new Tab(text: "皮肤科"),
   new Tab(text: "中医科"),
   new Tab(text: "妇产科"),
   new Tab(text: "其他"),
 ];
 

 String userId;
 String docId;
 var recommendDoc = List<DocumentSnapshot>();
 var visitPro;
 List visitNum = [0,0,0,0,0,0,0,0];

 getDocs(visitPro){
   //内科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[1].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[0]){
       //print(tabs[1]);
       Doc.documents.forEach((element){
         if(recommendDoc.isNotEmpty){
           recommendDoc.removeWhere((doc) =>
           doc.documentID == element.documentID
           );
         }
         recommendDoc.add(element);

       });
     }
     else{
       for(int j = 0; j < visitPro[0]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);
         }
       }
     });

 //外科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[2].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[1]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[1]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }

   });
  //五官科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[3].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[2]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[2]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }
   });
   //儿科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[4].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[3]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[3]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }
   });
   //皮肤科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[5].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[4]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[4]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }
   });
   //中医科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[6].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[5]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[5]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }
   });
   //妇产科
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[7].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[6]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[6]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }
   });
   //其他
   Firestore.instance.collection('Topic').document('alltopic').collection(tabs[8].text)
       .orderBy('view', descending: true).getDocuments().then((Doc){
     //print(visitPro[k]);
     if(Doc.documents.length < visitPro[7]){
       Doc.documents.forEach((element){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == element.documentID
         );
         recommendDoc.add(element);
       });
     }
     else{
       for(int j = 0; j < visitPro[7]; j ++){
         recommendDoc.removeWhere((doc) =>
         doc.documentID == Doc.documents[j].documentID
         );
         recommendDoc.add(Doc.documents[j]);

       }
     }
   });

   return recommendDoc;

 }

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
       Firestore.instance.collection('users').document(docId)
           .collection('HistoryTopic').getDocuments().then((doc){
         visitPro = Recommend().getNums(doc);
         setState(() {
         recommendDoc = getDocs(visitPro);
         });
         recommendDoc.sort((b,a) => a['view'].compareTo(b['view']));

       });
     });
   }).catchError((e){
     print(e);
   });

 }

 Future<Null> _handleRefresh() async {
   await Future.delayed(Duration(seconds: 1),(){
     FirebaseAuth.instance.currentUser().then((user){
       userId = user.uid;
       Firestore.instance.collection('users').where('uid', isEqualTo: userId)
           .getDocuments().then((docs){
         setState(() {
           docId = docs.documents[0].documentID;
         });
         Firestore.instance.collection('users').document(docId)
             .collection('HistoryTopic').getDocuments().then((doc){
           visitPro = Recommend().getNums(doc);
           setState(() {
             recommendDoc = getDocs(visitPro);
           });
           recommendDoc.sort((b,a) => a['view'].compareTo(b['view']));
         });
       });
     }).catchError((e){
       print(e);
     });
   });

   return null;
 }


 @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: tabs.length,
        child: new Scaffold(
          appBar: AppBar(
            title: SearchBar(),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: new TabBar(
              isScrollable: true,
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
                if(tab.text != '推荐'){
                  return StreamBuilder(
                      stream: Firestore.instance.collection('Topic').document('alltopic').collection(tab.text).snapshots(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData){
                          return const Text("Loading....");
                        }else{
                          return new ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot document = snapshot.data.documents[index];
                              return new Container(
                                height: 160,
                                margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 4,
                                        child:Text(
                                          document['title'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92)),
                                          maxLines: 1,
                                        )),
                                    Expanded(
                                        flex: 10,
                                        child:FlatButton(onPressed: () async{

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => TopicDetailPage(snap:document, tabs: tab.text)));
                                          Firestore.instance.runTransaction((transaction) async {
                                            DocumentSnapshot freshSnap = await transaction.get(document.reference);
                                            await transaction.update(freshSnap.reference, {
                                              'view': freshSnap['view'] + 1
                                            });
                                          });
                                          Firestore.instance.collection('users').document(docId).collection('HistoryTopic')
                                              .where('reftopic',isEqualTo: document.reference).getDocuments().then((refDoc){
                                            if(refDoc.documents.length == 0){
                                              Firestore.instance.collection('users/${docId}/HistoryTopic').add({
                                                'reftopic': document.reference,
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
                                              document['content'],
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
                                                  backgroundImage:NetworkImage(document['photoUrl']),
                                                  radius: 17.0,
                                                )
                                            ),
                                            Expanded(
                                                flex: 5,
                                                child: Text(document['username'], style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13),)
                                            ),
                                            Expanded(
                                                flex: 6,
                                                child: Text(CrudMethods().ReadableTime(document['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.comment,
                                                    size: 16,
                                                    color: Colors.black26,
                                                  ),
                                                )

                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Text(document['comment'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
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

                                                child: Text(document['view'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))

                                            ),

                                          ],
                                        )
                                    ),
                                    Divider(
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                              );
                            },

                          );
                        }
                      }

                  );
                }else{
                  Recommend recommend = new Recommend();
                  return RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: FutureBuilder(
                      future: CrudMethods().getRec(),
                      builder: (context, snapshot){
                        switch (snapshot.connectionState){
                          case ConnectionState.active:
                            visitPro = recommend.getNums(snapshot.data);
                            recommendDoc = getDocs(visitPro);
                            recommendDoc.sort((b,a) => a['view'].compareTo(b['view']));
                            return ListView.builder(
                              itemCount: recommendDoc.length,
                              itemBuilder: (context, index){
                                DocumentSnapshot document = recommendDoc[index];
                                List path = document.reference.path.split('/');
                                String tabText = path[2];
                                return new Container(
                                  height: 160,
                                  margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 4,
                                          child:Text(
                                            document['title'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92)),
                                            maxLines: 1,
                                          )),
                                      Expanded(
                                          flex: 10,
                                          child:FlatButton(onPressed: () async{
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => TopicDetailPage(snap:document, tabs: tabText)));
                                            Firestore.instance.runTransaction((transaction) async {
                                              DocumentSnapshot freshSnap = await transaction.get(document.reference);
                                              await transaction.update(freshSnap.reference, {
                                                'view': freshSnap['view'] + 1
                                              });
                                            });
                                            Firestore.instance.collection('users').document(docId).collection('HistoryTopic')
                                                .where('reftopic',isEqualTo: document.reference).getDocuments().then((refDoc){
                                              if(refDoc.documents.length == 0){
                                                Firestore.instance.collection('users/${docId}/HistoryTopic').add({
                                                  'reftopic': document.reference,
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
                                                document['content'],
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
                                                    backgroundImage:NetworkImage(document['photoUrl']),
                                                    radius: 17.0,
                                                  )
                                              ),
                                              Expanded(
                                                  flex: 5,
                                                  child: Text(document['username'], style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13),)
                                              ),
                                              Expanded(
                                                  flex: 6,
                                                  child: Text(CrudMethods().ReadableTime(document['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.comment,
                                                      size: 16,
                                                      color: Colors.black26,
                                                    ),
                                                  )

                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(document['comment'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
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

                                                  child: Text(document['view'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))

                                              ),

                                            ],
                                          )
                                      ),
                                      Divider(
                                        color: Colors.black26,
                                      )
                                    ],
                                  ),
                                );

                              },
                            );
                          case ConnectionState.none:
                            return Center(
                              child: Text('Loading'),
                            );
                          case ConnectionState.waiting:
                            return Center(
                              child: Text('Loading'),
                            );
                          case ConnectionState.done:
                            visitPro = recommend.getNums(snapshot.data);
                            recommendDoc = getDocs(visitPro);
                            recommendDoc.sort((b,a) => a['view'].compareTo(b['view']));
                            return ListView.builder(
                              itemCount: recommendDoc.length,
                              itemBuilder: (context, index){
                                DocumentSnapshot document = recommendDoc[index];
                                List path = document.reference.path.split('/');
                                String tabText = path[2];
                                return new Container(
                                  height: 160,
                                  margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 4,
                                          child:Text(
                                            document['title'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92)),
                                            maxLines: 1,
                                          )),
                                      Expanded(
                                          flex: 10,
                                          child:FlatButton(onPressed: () async{

                                            Navigator.push(context, MaterialPageRoute(builder: (context) => TopicDetailPage(snap:document, tabs: tabText)));
                                            Firestore.instance.runTransaction((transaction) async {
                                              DocumentSnapshot freshSnap = await transaction.get(document.reference);
                                              await transaction.update(freshSnap.reference, {
                                                'view': freshSnap['view'] + 1
                                              });
                                            });
                                            Firestore.instance.collection('users').document(docId).collection('HistoryTopic')
                                                .where('reftopic',isEqualTo: document.reference).getDocuments().then((refDoc){
                                              if(refDoc.documents.length == 0){
                                                Firestore.instance.collection('users/${docId}/HistoryTopic').add({
                                                  'reftopic': document.reference,
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
                                                document['content'],
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
                                                    backgroundImage:NetworkImage(document['photoUrl']),
                                                    radius: 17.0,
                                                  )
                                              ),
                                              Expanded(
                                                  flex: 5,
                                                  child: Text(document['username'], style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13),)
                                              ),
                                              Expanded(
                                                  flex: 6,
                                                  child: Text(CrudMethods().ReadableTime(document['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.comment,
                                                      size: 16,
                                                      color: Colors.black26,
                                                    ),
                                                  )

                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(document['comment'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
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

                                                  child: Text(document['view'].toString(), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))

                                              ),

                                            ],
                                          )
                                      ),
                                      Divider(
                                        color: Colors.black26,
                                      )
                                    ],
                                  ),
                                );

                              },
                            );
                        }


                      },
                    ),
                  );

                }
          }).toList()
            ),
          ),
        );
  }

  void search() {}


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
