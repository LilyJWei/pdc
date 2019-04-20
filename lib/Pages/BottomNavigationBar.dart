import 'package:flutter/material.dart';
import 'package:pdc/Pages/Follow.dart';
import 'package:pdc/Pages/MainPage.dart';
import 'package:pdc/Pages/MyInfo.dart';
import 'package:pdc/Pages/QandA.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState(){
    list
      ..add(MainPage())
      ..add(QandAPage())
      ..add(FollowPage())
      ..add(MyInfoPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon:
              _currentIndex == 0?
              Image(
                  image: AssetImage("images/icons/tab_main.png")
              ): Image(
                image: AssetImage("images/icons/tab_unchosenmain.png"),
              ),
              title: Text('主页', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
          ),
          BottomNavigationBarItem(
              icon:
              _currentIndex == 1?
              Image(
                  image: AssetImage("images/icons/tab_chosenquestion.png")
              ): Image(
                  image: AssetImage("images/icons/tab_question.png")
              ),
              title: Text('问答', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
          ),
          BottomNavigationBarItem(
              icon: _currentIndex == 2?
              Image(
                  image: AssetImage("images/icons/tab_chosenfollow.png")
              ): Image(
                  image: AssetImage("images/icons/tab_follow.png")
              ),
              title: Text('关注', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
          ),
          BottomNavigationBarItem(
              icon: _currentIndex == 3?
              Image(
                  image: AssetImage("images/icons/tab_chosenMyInfo.png")
              ): Image(
                  image: AssetImage("images/icons/my_info.png")
              ),
              title: Text('我的', style: TextStyle(color: Color.fromARGB(255, 240, 123, 135)))
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,

      ),
    );
  }
}
