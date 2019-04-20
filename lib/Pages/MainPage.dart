import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    //title section
    Widget titleSection = new Row(
      children: <Widget>[
        new Expanded(
          flex: 7,
          child: new Card(
              elevation: 1.0,
              color: Color.fromARGB(255, 241, 241, 242),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: new Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(color: Colors.black26))
                        ),

                      ),],
                  )) ),),
        Expanded(
            flex: 1,
            child: Container(
                child: IconButton(
                  icon: Image.asset('images/icons/tab_publish.png'),
                  onPressed: () {},
                )
            ))

      ],
    );




    Widget bottomSection = new BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Image(
                image: AssetImage("images/icons/tab_main.png")
            ),
            title: Text('主页', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
        ),
        BottomNavigationBarItem(
            icon: Image(
                image: AssetImage("images/icons/tab_question.png")
            ),
            title: Text('问答', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
        ),
        BottomNavigationBarItem(
            icon: Image(
                image: AssetImage("images/icons/tab_follow.png")
            ),
            title: Text('关注', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
        ),
        BottomNavigationBarItem(
            icon: Image(
                image: AssetImage("images/icons/my_info.png")
            ),
            title: Text('我的', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
        )
      ],

    );

    return new DefaultTabController(
        length: 10,
        child: new Scaffold(
          appBar: AppBar(
            title: titleSection,
            backgroundColor: Colors.white,
            bottom: new TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 3.5, color: Color.fromARGB(255, 240, 123, 135))),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                new Tab(text: "推荐"),
                new Tab(text: "内科"),
                new Tab(text: "外科"),
                new Tab(text: "五官科"),
                new Tab(text: "妇产科"),
                new Tab(text: "儿科"),
                new Tab(text: "皮肤科"),
                new Tab(text: "中医科"),
                new Tab(text: "妇产科"),
                new Tab(text: "其他"),
              ],
              labelColor: Color.fromARGB(255, 69, 69, 92),
              unselectedLabelColor: Color.fromARGB(255, 145, 153, 185),
            ),
          ),
          body: new Center(
            child: Image(
              image: AssetImage("images/icons/Oval.png"),
              fit: BoxFit.fill,
            ),
          ),
          bottomNavigationBar: bottomSection,
        ));
  }

  void search() {}
}
