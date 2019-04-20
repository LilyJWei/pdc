import 'package:flutter/material.dart';
import 'package:pdc/Pages/SearchBar.dart';

class QandAPage extends StatefulWidget {
  @override
  _QandAPageState createState() => _QandAPageState();
}

class _QandAPageState extends State<QandAPage> with AutomaticKeepAliveClientMixin{

  final List<Tab> tabs =  <Tab>[
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
        length: 10,
        child: new Scaffold(
          appBar: AppBar(
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
          body: new TabBarView(
              children: tabs.map((Tab tab){
                return new Center(child: new Text(tab.text));
              }).toList()
          ),
          //bottomNavigationBar: bottomSection,
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
