import 'package:flutter/material.dart';
import 'package:pdc/Pages/Setup/TopicManagement.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key key, this.tab, this.id}) : super(key: key);
  final String tab;
  final String id;
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  String _comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
              onPressed: (){
                Navigator.of(context).pop();
              }),
        title: Text('评论' ,style: TextStyle(color: Color.fromARGB(255, 69, 69, 92), fontWeight: FontWeight.w400),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.publish),
            color: Color.fromARGB(255, 240, 123, 135),
            tooltip: '发布',
            onPressed: () {
              // handle the press
              publishComment(_comment);
            },
          ),
        ],
      ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: TextField(
            maxLines: 20,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              hintText: "想对Ta说点什么",
              hintStyle: TextStyle(color: Color.fromARGB(255, 215, 212, 212), fontSize: 18),
              border: InputBorder.none,
            ),
            onChanged: (value){
              setState(() {
                _comment = value;
              });
            },
          ),

        )


    );
  }

  publishComment(String comment){
      if(comment == null){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('提示'),
              content: Text(('评论内容不能为空')),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
      else{
        TopicManagement().storeNewComment(comment, widget.id, widget.tab,context);
      }

  }
}
