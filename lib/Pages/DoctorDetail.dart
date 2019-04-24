import 'package:flutter/material.dart';
import 'package:pdc/Pages/QuestionDetail.dart';

class DoctorDetailPage extends StatefulWidget {
  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black26,),
            onPressed: (){
              Navigator.pop(context);
            }),
      ),
      body:




      Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //第一大行，王外科的个人简介
          Container(
            //color: Colors.black26,
            height: 150,
            margin: EdgeInsets.only(top: 0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, top: 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                          image: AssetImage(
                              "images/icons/3x/doctor.png")
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 10, top: 40),
                          child: Text('王外科',style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),
                              fontSize: 16,fontWeight: FontWeight.w500),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 35, top: 40),
                          child: Text('职称：主治医生',
                            style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15,top: 5),
                      child: Text('专长：外科门诊',
                      style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15,top: 5),
                      child: Text('Ta解决的问题：1234',
                        style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                    )
                  ],
                ),
                Expanded(child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: IconButton(
                        icon: Image(image: AssetImage("images/icons/2x/follow.png"),
                          width: 80,
                          height: 90,),
                        onPressed: () {})
                ),)
              ],
            ),
            ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('Ta的全部回答', style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),
                fontSize: 16,fontWeight: FontWeight.w500)),
          ),
          Container(
            height: 2,
            margin: EdgeInsets.only(bottom: 0),
            child: Divider(
              color: Colors.black26,
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 18,top: 0),
            height: 23,
            color: Color.fromARGB(255, 246, 241, 241),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:3,
                  child: Text('提问标题',style: TextStyle(
                      color: Color.fromARGB(255, 145, 153, 185),
                      fontSize: 14),),
                ),
                Expanded(
                  flex: 1,
                  child: Text('日期', style: TextStyle(
                      color: Color.fromARGB(255, 145, 153, 185),
                      fontSize: 14),),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
                itemBuilder: (BuildContext context, int index){
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
                          child: Text('我今天一直腰疼', style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14),),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('21/4/2019',style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 14, fontWeight: FontWeight.w300)),
                        )
                      ],
                    ),
                  )

              );
            }),
          )



        ],
      ),

    );
  }
}
