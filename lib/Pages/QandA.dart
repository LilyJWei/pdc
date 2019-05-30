import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';
import 'package:pdc/Pages/QuestionDetailDoctor.dart';
import 'package:pdc/Pages/SearchBar.dart';
import 'package:pdc/Pages/Setup/Recommend.dart';
import 'package:pdc/Pages/Setup/crud.dart';
import 'package:pdc/Pages/TopicDetail.dart';

class QandAPage extends StatefulWidget {
  @override
  _QandAPageState createState() => _QandAPageState();
}

class _QandAPageState extends State<QandAPage> with AutomaticKeepAliveClientMixin {

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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[1].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[2].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[3].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[4].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[5].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[6].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[7].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
    Firestore.instance.collection('Questions').document('alltopic').collection(tabs[8].text)
        .orderBy('time', descending: true).getDocuments().then((Doc){
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
            .collection('HistoryQuestion').getDocuments().then((doc){
          visitPro = Recommend().getQuesNums(doc);
          setState(() {
            recommendDoc = getDocs(visitPro);
          });
          recommendDoc.sort((b,a) => a['time'].compareTo(b['time']));

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
              .collection('HistoryQuestion').getDocuments().then((doc){
            visitPro = Recommend().getQuesNums(doc);
            setState(() {
              recommendDoc = getDocs(visitPro);
            });
            recommendDoc.sort((b,a) => a['time'].compareTo(b['time']));

          });
        });
      }).catchError((e){
        print(e);
      });
    });

    return null;
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: tabs.length,
        child: new Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: SearchBar(),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,

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
            body: new Column(
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
                  flex: 18,
                  child: new TabBarView(
                      children: tabs.map((Tab tab) {
                        if(tab.text != '推荐'){
                          return StreamBuilder(
                              stream: Firestore.instance.collection('Questions').document('alltopic')
                                  .collection(tab.text).snapshots(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  return const Text('Loading....');
                                }else{
                                  return new ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        DocumentSnapshot document = snapshot.data.documents[index];
                                        return new Container(
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
                                                        (builder: (context) => QuestionDetailDoctorPage(snap: document, tabs: tab.text))) ;
                                                    }else{
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context) => QuestionDetailPage(snap: document, tabs: tab.text)));

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

                                        );
                                      });
                                }

                              }
                          );
                        }else{
                          Recommend recommend = new Recommend();
                          return RefreshIndicator(
                            onRefresh: _handleRefresh,
                            child: FutureBuilder(
                              future: CrudMethods().getQues(),
                              builder: (context, snapshot){
                                switch (snapshot.connectionState){
                                  case ConnectionState.active:
                                   return null;
                                  case ConnectionState.none:
                                    return Center(
                                      child: Text('Loading'),
                                    );
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: Text('Loading'),
                                    );
                                  case ConnectionState.done:
                                    visitPro = recommend.getQuesNums(snapshot.data);
                                    recommendDoc = getDocs(visitPro);
                                    recommendDoc.sort((b,a) => a['time'].compareTo(b['time']));
                                    return ListView.builder(
                                      itemCount: recommendDoc.length,
                                      itemBuilder: (context, index){
                                        DocumentSnapshot document = recommendDoc[index];
                                        List path = document.reference.path.split('/');
                                        String tabText = path[2];
                                        return new Container(
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

                                        );

                                      },
                                    );
                                }


                              },
                            ),
                          );
                        }

                      }).toList()
                  ),)
              ],
            )
          //bottomNavigationBar: bottomSection,
        ));
  }
}