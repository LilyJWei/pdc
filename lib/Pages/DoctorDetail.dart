import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';
import 'package:pdc/Pages/Setup/UserManagement.dart';
import 'package:pdc/Pages/Setup/crud.dart';

class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({Key key, this.doctorSnap}) : super(key: key);
  final DocumentSnapshot doctorSnap;
  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {

  int _answerNumber;
  bool _isFollowed;
  String docId;
  String userId;
  @override
  void initState() {
   _isFollowed = false;
    _answerNumber = 0;
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
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black26,),
            onPressed: (){
              Navigator.pop(context);
            }),
      ),
      body:
      Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //第一大行，王外科的个人简介
          Container(
            //color: Colors.black26,
            height: 150,
            margin: EdgeInsets.only(top: 0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, top: 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                          image: NetworkImage(widget.doctorSnap['photoUrl'])
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 10, top: 40),
                          child: Text(widget.doctorSnap['displayName'],style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),
                              fontSize: 16,fontWeight: FontWeight.w500),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 35, top: 40),
                          child: Text('职称：${widget.doctorSnap['technicaltitle']}',
                            style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15,top: 5),
                      child: Text('专长：${widget.doctorSnap['speciality']}',
                      style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                    ),
                    StreamBuilder(
                      stream: Firestore.instance.collection('users').document(widget.doctorSnap.documentID).collection('Answers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Text('Loading...');
                        }else{
                          _answerNumber = snapshot.data.documents.length;
                          return Container(
                            margin: EdgeInsets.only(left: 15,top: 5),
                            child: Text('Ta解决的问题：${_answerNumber}',
                              style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                          );
                        }
                      }
                    )
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: Firestore.instance.collection('users').document(docId)
                          .collection('Doctor').where('uid', isEqualTo: widget.doctorSnap['uid']).snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Text('Loading');
                        }else{
                          if(snapshot.data.documents.length == 0){
                            _isFollowed = false;
                          }else{
                            _isFollowed = true;
                          }
                          return Container(
                              margin: EdgeInsets.only(left: 20),
                              child: _isFollowed ?   IconButton(
                                  icon: Image(image: AssetImage(
                                      "images/icons/2x/hasFollowed.png"),
                                    width: 80,
                                    height: 90,),
                                  onPressed: () {
                                    UserManagement().unFollowDoctor(widget.doctorSnap);
                                    setState(() {
                                      _isFollowed = false;
                                    });
                                  }):
                              IconButton(
                                  icon: Image(image: AssetImage(
                                      "images/icons/2x/follow.png"),
                                    width: 80,
                                    height: 90,),
                                  onPressed: () {
                                    UserManagement().followDoctor(widget.doctorSnap);
                                    setState(() {
                                      _isFollowed = true;
                                    });
                                  })
                          );

                        }


                      }),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('Ta的全部回答', style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),
                fontSize: 16,fontWeight: FontWeight.w500)),
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(bottom: 0),
            child: Divider(
              color: Colors.black26,
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 18,top: 0),
            height: 23,
            color: Color.fromARGB(255, 246, 241, 241),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:3,
                  child: Text('提问标题',style: TextStyle(
                      color: Color.fromARGB(255, 145, 153, 185),
                      fontSize: 14),),
                ),
                Expanded(
                  flex: 1,
                  child: Text('日期', style: TextStyle(
                      color: Color.fromARGB(255, 145, 153, 185),
                      fontSize: 14),),
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').document(widget.doctorSnap.documentID).collection('Answers')
                  .snapshots(),
              builder: (context, snap) {
                if(!snap.hasData){
                  return Center(
                    child: Text('Loading...'),
                  );
                }else{
                  return ListView.builder(
                      itemCount: snap.data.documents.length,
                      itemBuilder: (BuildContext context, int index){
                        DocumentSnapshot document = snap.data.documents[index];
                        DocumentReference ref = document['refreply'];
                        String path = ref.path;
                        List splitPath = path.split('/');
                        String tabText = splitPath[2];
                          return StreamBuilder(
                            stream: ref.snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Center(
                                  child: Text('Loading...'),
                                );
                              }else{
                                DocumentSnapshot document = snapshot.data;
                                return new Container(
                                    padding: EdgeInsets.only(left: 18),
                                    height: 50,
                                    child: FlatButton(
                                      padding: EdgeInsets.only(left: 0),
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionDetailPage(snap:document, tabs: tabText))) ;
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailPage()));
                                      },
                                      child: new Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 4,
                                            child: Text(document['title'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14),),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(CrudMethods().ReadableTime(document['time'].toDate().toString()),style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14, fontWeight: FontWeight.w300)),
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
            ),
          )
        ],
      ),

    );
  }


}
