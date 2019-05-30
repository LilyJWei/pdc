import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';

class SearchQuestionPage extends StatefulWidget {
  @override
  _SearchQuestionPageState createState() => _SearchQuestionPageState();
}

class _SearchQuestionPageState extends State<SearchQuestionPage> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1) + value.substring(1);

    List tabs = ['外科','内科','五官科','儿科','皮肤科','中医科','妇产科','其他'];

    if (queryResultSet.length == 0 && value.length == 1) {
      tabs.forEach((tab){
        Firestore.instance.collection('Questions').document('alltopic').collection(tab.toString())
            .getDocuments().then((QuerySnapshot docs) {
          for (int i = 0; i < docs.documents.length; ++i) {
            queryResultSet.add(docs.documents[i].reference);
          }
        });
      });

    } else {
      tempSearchStore = [];
      for(int i = 0; i < queryResultSet.length; i++){
        Firestore.instance.document(queryResultSet[i].path).get().then((snap){
          if(snap['title'].startsWith(capitalizedValue)) {
            setState(() {
              tempSearchStore.add(snap);
            });
          }
        });
      }
//      queryResultSet.forEach((element) {
//        if (element['title'].startsWith(capitalizedValue)) {
//          setState(() {
//            tempSearchStore.add(element);
//          });
//        }
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black26,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: tempSearchStore.length,
            itemBuilder: (context, index){

              DocumentSnapshot snap = tempSearchStore[index];
              DocumentReference ref = snap.reference;
              List path = ref.path.split('/');
              String tab = path[2];
              return buildResultCard(tempSearchStore[index],tab,context);
            },

          )
        ]));
  }
}
Widget buildResultCard(data, tab,context) {

  return FlatButton(
    child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),),
        elevation: 0.0,
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 69, 69, 92),
                  fontSize: 18.0,
                ),
              ),
              Divider(color: Colors.black26,)
            ],
          ),
        )
    ),
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          QuestionDetailPage(snap: data,tabs: tab,)));
    },
  );

}