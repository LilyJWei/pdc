import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdc/Pages/Setup/crud.dart';

class QuestionDetailPage extends StatefulWidget {
  const QuestionDetailPage({Key key, this.snap,this.tabs}) : super(key: key);
  final DocumentSnapshot snap;
  final Tab tabs;
  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  @override
  Widget build(BuildContext context) {
    //当前问题的类别
    String tabText = widget.tabs.text;
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
      body: SingleChildScrollView(
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
                          child: Text(CrudMedthods().ReadableTime(snap['time'].toDate().toString()),style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
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
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height:40,
                                    width:40,
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
                                  Expanded(
                                    child: Container(
                                      height: 87,
                                      width: 80,
                                      margin: EdgeInsets.only(left: 50,right: 10),
                                      child: IconButton(icon: Image(image: AssetImage("images/icons/3x/follow.png"),width: 87,height: 123,), onPressed: null),
                                    ),)

                                ],
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 20,right: 20,top: 5),
                              child: Text('你这种情况应该是坐的时间太长了，你需要多活动活动，如果还是很疼的话建议来医院看看',
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
                }else{
                  return SizedBox(height: 50,);
                }

              }
            )


  ],),
      )
      ,
      );
  }
}
