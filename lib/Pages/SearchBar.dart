import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child:titleSection,
    );
  }
}
