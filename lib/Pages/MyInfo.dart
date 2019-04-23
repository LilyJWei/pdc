import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 18),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 70,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/icons/avatar1.jpg"),
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
                            '我是小可爱',
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
                  child: Text('历史纪录', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontSize: 16) ,),
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
        ],
      ),
    );
  }
}
