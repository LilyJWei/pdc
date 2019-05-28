import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/SearchBar.dart';
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
                                            child: Text(ReadableTime(document['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
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
