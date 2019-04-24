import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';
import 'package:pdc/Pages/SearchBar.dart';

class QandAPage extends StatefulWidget {
  @override
  _QandAPageState createState() => _QandAPageState();
}

class _QandAPageState extends State<QandAPage> with AutomaticKeepAliveClientMixin {

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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 10,
        child: new Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: SearchBar(),
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
            body: new Column(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 18),
                        height: 23,
                        color: Color.fromARGB(255, 246, 241, 241),
                        child: new Row(
                          children: <Widget>[
                            Expanded(flex: 4,
                                child: Text('提问标题', style: TextStyle(
                                    color: Color.fromARGB(255, 145, 153, 185),
                                    fontSize: 14),)),
                            Expanded(flex: 2,
                                child: Text('状态', style: TextStyle(
                                    color: Color.fromARGB(255, 145, 153, 185),
                                    fontSize: 14),)),
                            Expanded(flex: 2,
                                child: Text('日期', style: TextStyle(
                                    color: Color.fromARGB(255, 145, 153, 185),
                                    fontSize: 14),)),

                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        )
                    )),
                Expanded(
                  flex: 18,
                  child: new TabBarView(
                      children: tabs.map((Tab tab) {
                        return new ListView.builder(
                          itemCount: 8,
                            itemBuilder: (BuildContext context, int index) {
                              return new Container(
                                padding: EdgeInsets.only(left: 18),
                                height: 50,
                                child: FlatButton(
                                  padding: EdgeInsets.only(left: 0),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionDetailPage())) ;
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailPage()));
                                    },
                                    child: new Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: Text('[' + tab.text +'] 我今天一直腰疼', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text('已解决', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text('21/4/2019', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14,
                                          fontWeight: FontWeight.w300
                                          )),
                                        )
                                      ],
                                    ),
                                )

                              );
                            });
                      }).toList()
                  ),)
              ],
            )
          //bottomNavigationBar: bottomSection,
        ));
  }
}