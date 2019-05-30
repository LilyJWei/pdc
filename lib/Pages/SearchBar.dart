import 'package:flutter/material.dart';
import 'package:pdc/Pages/PublishTopic.dart';
import 'package:pdc/Pages/Search.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
            Expanded(
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
                                    hintStyle: TextStyle(color: Colors.black26)),
                              onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  SearchPage()));
                              },
                            ),

                          ),],
                      )) ),),
            Expanded(
                flex: 1,
                child: Container(
                    child: IconButton(
                      icon: Image.asset('images/icons/tab_publish.png'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => PublishTopicPage()));
                      },
                    )
                ))

          ],)

    );
  }
}
