import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/DoctorDetail.dart';
import 'package:pdc/Pages/Setup/TopicManagement.dart';
import 'package:pdc/Pages/Setup/crud.dart';

class QuestionDetailDoctorPage extends StatefulWidget {
  const QuestionDetailDoctorPage({Key key, this.snap,this.tabs}) : super(key: key);
  final DocumentSnapshot snap;
  final String tabs;
  @override
  _QuestionDetailDoctorPageState createState() => _QuestionDetailDoctorPageState();
}

class _QuestionDetailDoctorPageState extends State<QuestionDetailDoctorPage> {
  String _content;
  String _workField;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('users').where('uid', isEqualTo: user.uid)
          .getDocuments().then((docs){
        setState(() {
          DocumentSnapshot snapshot = docs.documents[0];
          _workField = snapshot['workfield'];
        });
      });
    }).catchError((e){
      print(e);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //当前问题的类别
    String tabText = widget.tabs;
    DocumentSnapshot snap = widget.snap;
    String docId = snap.documentID;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black26,),
            onPressed: (){
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //提问部分
              Container(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.only(left: 0),
                      margin: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 5),
                      child: Text(snap['title'],
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),
                            fontSize: 20, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(snap['username'],style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                                fontSize: 12),),
                          ),
                          Expanded(
                            child: Text(snap['gender'], style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                                fontSize: 12),),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(CrudMethods().ReadableTime(snap['time'].toDate().toString()),style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                                fontSize: 12),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20, top: 5, bottom: 5),
                      child: Text(snap['content'],
                        style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 15),),
                    )
                  ],
                ),
              ),
              //回答部分
              StreamBuilder(
                  stream: Firestore.instance.collection('Questions').document('alltopic').collection(tabText)
                      .document(docId).collection('reply').snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){

                      return Text('Loading....');

                    }else if(snapshot.data.documents.length == 1){
                      DocumentSnapshot document = snapshot.data.documents[0];
                      return Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FlatButton(
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height:45,
                                          width:45,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(1.0),
                                            child: Image.network(document['photoUrl']),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 15,right: 35),
                                                  child: Text(document['username'],style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),
                                                      fontSize: 16,fontWeight: FontWeight.w500),),
                                                ),
                                                Container(
                                                  child: Text('职称：' + document['technicaltitle'],
                                                    style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: Text('专长：' + document['speciality'],
                                                style:TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12) ,),
                                            )
                                          ],
                                        ),
                                        //加关注
//                                  Expanded(
//                                    child: Container(
//                                      height: 87,
//                                      width: 80,
//                                      margin: EdgeInsets.only(left: 50,right: 10),
//                                      child: IconButton(icon: Image(image: AssetImage("images/icons/3x/follow.png"),width: 87,height: 123,), onPressed: null),
//                                    ),)

                                      ],
                                    ),
                                  ),
                                  onPressed: (){
                                    //find the answering doctor
                                    Firestore.instance.collection('users').where('uid', isEqualTo: document['uid'])
                                        .getDocuments().then((docs){
                                      DocumentSnapshot doctorSnap = docs.documents[0];
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetailPage(doctorSnap: doctorSnap)));
                                    });

                                  },
                                ),
                                Container(
                                  // margin: EdgeInsets.only(left: 20,right: 20,top: 5),
                                  child: Text(document['content'],
                                    style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),fontSize: 15,),),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20,top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(icon: Image(image:AssetImage("images/icons/3x/Telephone.png"),),
                                      onPressed: (){},),
                                    Text('和医生电话沟通', style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),fontSize: 15,),)
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('点击填写详细信息，向该医生付费咨询',style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),fontSize: 15,),),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }else if(_workField == tabText){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30,right: 30,bottom: 5, top: 5),
                            child: Text('回答该问题:', style:TextStyle(
                              color: Color.fromARGB(255, 101, 104, 127), fontSize: 16, fontWeight: FontWeight.w500
                            )),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30,right: 30,bottom: 5, top: 5),
                            child: Theme(
                              data: new ThemeData(primaryColor: Color.fromARGB(255, 240, 123, 135), hintColor:Color.fromARGB(255, 249, 223, 221) ),
                              child: TextField(
                                maxLines: 15,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                onChanged: (value){
                                  setState(() {
                                    _content = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            child: IconButton(
                              icon: Image.asset('images/icons/publish.png', height: 200, width: 100,),
                              onPressed: (){
                                //add reply
                                //add users table reply
                                TopicManagement().storeNewReply(_content, tabText, docId);
                              },
                            ),

                          ),
                        ],
                      );
                    }
                    else{
                      return SizedBox(height: 50,);
                    }

                  }
              )


            ],),
        ),
      )
      ,
    );
  }
}
