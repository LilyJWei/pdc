import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/Comment.dart';
import 'package:pdc/Pages/MainPage.dart';

class TopicDetailPage extends StatefulWidget {
  const TopicDetailPage({Key key, this.snap,this.tabs}) : super(key: key);
  final DocumentSnapshot snap;
  final Tab tabs;
  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {

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

  @override
  Widget build(BuildContext context) {
    String tabText = widget.tabs.text;
    DocumentSnapshot snap = widget.snap;
    String docId = snap.documentID;
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body: StreamBuilder(
                stream: Firestore.instance.collection('Topic').document('alltopic').collection(tabText)
                    .document(widget.snap.documentID).collection('comments').snapshots(),
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
                            document = snapshot.data.documents[index - 1];
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
                                                    backgroundImage: AssetImage("images/icons/avatar2.jpg"),
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
                                                      child: index == 0? Text(ReadableTime(snap['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),):
                                                      Text(ReadableTime(document['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),),
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
//        body: StreamBuilder(
//            stream: Firestore.instance.collection('Topic').document('alltopic').collection(tabText)
//                .document(widget.snap.documentID).collection('comments').snapshots(),
//            builder: (context, snapshot){
//              if(!snapshot.hasData){
//                return const Text("Loading....");
//              }else{
//                int length = snapshot.data.documents.length;
//                return ListView.builder(
//                  itemCount: length + 1,
//                  itemBuilder: (BuildContext context, int index) {
//                    DocumentSnapshot document;
//                    if(index >= 1){
//                      document = snapshot.data.documents[index - 1];
//                    }
//                    else{
//                      document = null;
//                    }
//                    return Container(
//                      alignment: Alignment.center,
//                      padding: const EdgeInsets.all(16.0),
//                      color: Colors.black26,
//                      height: 170,
//                      margin: EdgeInsets.only(top: 8),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              crossAxisAlignment: CrossAxisAlignment.stretch,
//                              children: <Widget>[
//                                Container(
//                                  margin: EdgeInsets.only(left: 50,right: 20),
//                                  child: index == 0 ? Text(snap['content'],
//                                    style:  TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 14 ),):
//                                  Text(document['content'],
//                                    style:  TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 14 ),),
//                                ),
//                                Row(
//                                  children: <Widget>[
//                                    Container(
//                                      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
//                                      child: CircleAvatar(
//                                        backgroundImage: AssetImage("images/icons/avatar2.jpg"),
//                                        radius: 15,
//                                      ),
//                                    ),
//
//                                    Container(
//                                      child: index == 0 ? Text(snap['username'], style: TextStyle(color: Color.fromARGB(255,3,121,251),fontSize: 12),)
//                                          : Text(document['username'], style: TextStyle(color: Color.fromARGB(255,3,121,251),fontSize: 12),),
//                                    ),
//                                    Container(
//                                      child: index == 0? Text('楼主', style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 12),)
//                                          : Text(index.toString() + '楼',style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 12) ),
//                                    )
//                                  ],
//                                ),
//                                Container(
//                                  margin: EdgeInsets.only(left: 50),
//                                  child: Row(
//                                    children: <Widget>[
//                                      Container(
//                                        child: index == 0? Text(ReadableTime(snap['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),):
//                                        Text(ReadableTime(document['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),),
//                                      ),
//                                      Container(
//                                        child: index > 0 ? Text('赞',style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10)):
//                                        Text(' '),
//                                      ),
//                                      Container(
//                                          child: index > 0? IconButton(icon: Icon(Icons.thumb_up), iconSize: 15,
//                                              //color: _likeIconColor(index, isLike),
//                                              onPressed: (){
//                                                Firestore.instance.runTransaction((transaction) async {
//                                                  DocumentSnapshot freshSnap = await transaction.get(document.reference);
//                                                  if(document['like'] == true){
//                                                    await transaction.update(freshSnap.reference, {
//                                                      'like': false
//                                                    });
//                                                  }else{
//                                                    await transaction.update(freshSnap.reference, {
//                                                      'like': true
//                                                    });
//                                                  }
//
//                                                });
//
//                                              }): Text(" ")
//                                      )
//                                    ],
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//
//                    );
//                  },
//
//                );
//              }
//            }
//
//        ),
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
                       Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                     },
                   )
                   
               ),
               Expanded(
                 flex: 3,
                 child: IconButton(icon: Icon(Icons.favorite_border,color: Colors.black26,), onPressed: null),
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
        title: Text('今天腰疼好难受' ,style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontWeight: FontWeight.w500),),
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
