import 'dart:async' as prefix1;
import 'dart:core';
import 'dart:core' as prefix0;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/Setup/UserManagement.dart';
import 'package:pdc/Pages/Setup/crud.dart';
import 'package:pdc/Pages/Setup/signIn.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  bool getuserFlag = false;
  var me;

  @override
  void initState(){
    super.initState();
//    if(widget.user != null){
//      CrudMedthods().getData().then((QuerySnapshot docs){
//        if(docs.documents.isNotEmpty){
//          getuserFlag = true;
//          me = docs.documents[0].data;
//        }
//      });
//    }else{
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
//    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('我', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 18),),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: FutureBuilder<Object>(
              future: CrudMedthods().getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  DocumentSnapshot me = snapshot.data.documents[0];
                  getuserFlag = true;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      getuserFlag ?
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                //backgroundImage: AssetImage("images/icons/avatar1.jpg"),
                                backgroundImage: NetworkImage(me['photoUrl']),
                                radius: 30,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 10),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      me['displayName'],
                                      style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 18 ),
                                    ) ,),
                                  Expanded(
                                    flex: 1,
                                    child:Text(
                                      '简介： 我是小可爱',
                                      style: TextStyle(color: Color.fromARGB(255, 101, 104, 127), fontSize: 12),
                                    ) ,),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 130),
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: null,
                                ),
                              ),)
                          ],
                        ),
                      ):
                      Container(
                        child:Text('waiting',textAlign: TextAlign.center,),
                        height: 70,
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      //问题
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 6, top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Icon(Icons.question_answer, color:  Color.fromARGB(255, 240, 123, 135),),
                            ),
                            Expanded(
                              flex: 7,
                              child: Text('我的问题', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 16) ,),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(icon: Icon(Icons.chevron_right), onPressed: null, color: Colors.black26,),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      //赞
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 6, top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Icon(Icons.thumb_up, color:  Color.fromARGB(255, 240, 123, 135),),
                            ),
                            Expanded(
                              flex: 7,
                              child: Text('我的赞', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 16) ,),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(icon: Icon(Icons.chevron_right), onPressed: null, color: Colors.black26,),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      //评论
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 6, top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Icon(Icons.comment, color: Color.fromARGB(255, 240, 123, 135),),
                            ),
                            Expanded(
                              flex: 7,
                              child: Text('我的评论', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 16) ,),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(icon: Icon(Icons.chevron_right), onPressed: null, color: Colors.black26,),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      //历史纪录
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 6, top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Icon(Icons.history, color:  Color.fromARGB(255, 240, 123, 135),),
                            ),
                            Expanded(
                              flex: 7,
                              child: Text('历史记录', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 16) ,),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(icon: Icon(Icons.chevron_right), onPressed: null, color: Colors.black26,),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black26,
                      ),
                      FlatButton(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 40,top: 50,right: 30),
                            width: 100,
                            height: 100,
                            child: Text('退出登录',style: TextStyle(
                              color: Color.fromARGB(255, 240, 123, 135),fontSize: 16
                            ),),
                          ),
                        ),
                        onPressed: (){
                          UserManagement().signOut();
                          Navigator.of(context).pop('/LoginPage');
                        },
                      )
                    ],
                  );
                }else{
                  return Center(
                    child: Text(
                      'Loading'
                    ),
                  );

                }

              }
            ),
          );

  }


}
