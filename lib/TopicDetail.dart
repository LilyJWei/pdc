import 'package:flutter/material.dart';
import 'package:pdc/Pages/MainPage.dart';

class TopicDetailPage extends StatefulWidget {
  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder,
        body:
              ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    color: Colors.white,
                    height: 170,
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      children: <Widget>[

                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Column(
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
                                        child: Text('我是小可爱' + index.toString() + '号', style: TextStyle(color: Color.fromARGB(255,3,121,251),fontSize: 12),),
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
                                    child: Text('今天拖地的时候闪到了腰，好疼啊，有没有人能分享一下好用的药膏  今天拖地的时候闪到了腰，好疼啊，有没有人能分享一下好用的药膏  今天拖地的时候闪到了腰，好疼啊，有没有人能分享一下好用的药膏',
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
                                          child: Text('22/4/2019',style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10),),
                                        ),
                                        Expanded(
                                          flex: 0,
                                          child: Text('赞',style: TextStyle(color: Color.fromARGB(255, 145, 153, 185),fontSize: 10)),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(icon: Icon(Icons.thumb_up) , iconSize: 10, onPressed: null),
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
            ),
       bottomNavigationBar:BottomAppBar(
         child: Container(
           height: 50,
           child: Row(
             children: <Widget>[
               Expanded(
                 flex: 4,
                   child: TextField(
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(left: 15),
                       hintText: "想对Ta说点什么",
                       hintStyle: TextStyle(color: Color.fromARGB(255, 215, 212, 212), fontSize: 12),
                       border: InputBorder.none,
                 ),)
               ),
               Expanded(
                 flex: 1,
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
}
