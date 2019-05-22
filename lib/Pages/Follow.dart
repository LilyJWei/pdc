import 'package:flutter/material.dart';
import 'package:pdc/Pages/DoctorDetail.dart';
import 'package:pdc/Pages/TopicDetail.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "帖子"),
    new Tab(text: "医生"),
  ];


  Widget topic(BuildContext context, int index){
    return new Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 4,
            child:Text(
              '今天腰疼很难受',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92)),
              maxLines: 1,
            )),
        Expanded(
            flex: 10,
            child:FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TopicDetailPage()));
            },
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  "九月初手臂划伤导致肌腱断裂四根，神经没有受伤，修复缝针后已经有四个多月，现在局部摸起来有点木,就是没有太大知觉，可以伸直弯曲",
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
                      backgroundImage: AssetImage("images/icons/Oval.png"),
                      radius: 15.0,
                    )
                ),
                Expanded(
                    flex: 5,
                    child: Text( "长颈鹿好萌", style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13),)
                ),
                Expanded(
                    flex: 6,
                    child: Text("12/4/2019", style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                ),
                Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.comment,
                        size: 16,
                        color: Colors.black26,
                      ),
                    )

                ),
                Expanded(
                    flex: 2,
                    child: Text("35", style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
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
                    child: Text("1234", style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
                ),

              ],
            )
        ),
        Divider(
          color: Colors.black26,
        )
      ],
    );
  }

  Widget doctor(BuildContext context, int index ) {
    return new Row(
      children: <Widget>[
        Container(
          child: CircleAvatar(
            backgroundImage: AssetImage("images/icons/doctor.png"),
            radius: 20,
          ),

        ),
        FlatButton(
          child: Container(
            margin: EdgeInsets.only(left: 21),
            width: 250,
            child: Text(
              '我外科贼厉害',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 69, 69, 92) ),
            ),
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorDetailPage()));
          },
        ),

        Expanded(
          flex: 3,
          child: Container(
            // margin: EdgeInsets.only(left: 20, right: 10),
              child: IconButton(
                icon: Icon(Icons.more_vert),
                iconSize: 18,
                color: Colors.black12,
                onPressed: (){},
              )
          ),)

      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('我的关注', textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 69, 69, 92)),),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
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
                 return new ListView.builder(
                   itemBuilder: (BuildContext context, int index){
                     return new Container(
                        height: tab.text == '医生'? 80: 160,
                        margin: EdgeInsets.only(left: 18),
                       child: tab.text == '医生'? doctor(context,index): topic(context,index),
                     );
                   }

                 );
               }
           ).toList()
        ),
      ),

    );
  }
}


