import 'package:flutter/material.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                        onPressed: null)
                ),)
              ],
            ),
            ),
        ],
      ),

    );
  }
}
