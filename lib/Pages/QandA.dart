import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';
import 'package:pdc/Pages/SearchBar.dart';
import 'package:pdc/Pages/Setup/crud.dart';

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
        length: tabs.length,
        child: new Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: SearchBar(),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,

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
                        return StreamBuilder(
                          stream: Firestore.instance.collection('Questions').document('alltopic')
                            .collection(tab.text).snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return const Text('Loading....');
                            }else{
                              return new ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    DocumentSnapshot document = snapshot.data.documents[index];
                                    return new Container(
                                        padding: EdgeInsets.only(left: 18),
                                        height: 50,
                                        child: FlatButton(
                                          padding: EdgeInsets.only(left: 0),
                                          onPressed: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionDetailPage(snap: document, tabs: tab))) ;
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailPage()));
                                          },
                                          child: new Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 4,
                                                child: Text( document['title'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(document['status'], style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(CrudMedthods().ReadableTime(document['time'].toDate().toString()), style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14,
                                                    fontWeight: FontWeight.w300
                                                )),
                                              )
                                            ],
                                          ),
                                        )

                                    );
                                  });
                            }

                          }
                        );
                      }).toList()
                  ),)
              ],
            )
          //bottomNavigationBar: bottomSection,
        ));
  }
}