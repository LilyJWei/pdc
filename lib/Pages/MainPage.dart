import 'package:flutter/material.dart';
import 'package:pdc/Pages/SearchBar.dart';
import 'package:pdc/Pages/Setup/signIn.dart';
import 'package:pdc/TopicDetail.dart';

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

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: tabs.length,
        child: new Scaffold(
          appBar: AppBar(
            title: SearchBar(),
            leading: null,
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
                return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      height: 160,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                              child:Text(
                            '['+ tab.text + '] 今天腰疼很难受',
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
                                      child: Text("长颈鹿好萌", style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13),)
                                  ),
                                  Expanded(
                                    flex: 6,
                                      child: Text("12/4/2019", style: TextStyle(color: Color.fromARGB(255, 145, 153, 185), fontSize: 13))
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
                      ),
                    );
                  },

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
