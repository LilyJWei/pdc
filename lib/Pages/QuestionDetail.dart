import 'package:flutter/material.dart';

class QuestionDetailPage extends StatefulWidget {
  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black26,),
            onPressed: (){
          Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          //提问部分
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //padding: EdgeInsets.only(left: 0),
                    margin: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 5),
                    child: Text('我的腰持续疼了一天,这正常吗? ',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),
                          fontSize: 20, fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 3),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('我是小可爱',style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                          fontSize: 12),),
                        ),
                        Expanded(
                          child: Text('女', style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                              fontSize: 12),),
                        ),
                        Expanded(
                          child: Text('19岁',style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                              fontSize: 12),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('22/04/2019',style: TextStyle(color:Color.fromARGB(255, 145, 153, 185),
                            fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20, top: 5, bottom: 5),
                    child: Text('我从昨天开始就持续腰疼,之前什么也没干啊，这样莫名其妙的腰疼正常吗',
                    style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 15),),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            //回答部分
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: new Image.asset('images/icons/doctor.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 35),
                                  child: Text('王外科',style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),
                                  fontSize: 16,fontWeight: FontWeight.w500),),
                                ),
                                Container(
                                  child: Text('职称：主治医生',
                                  style: TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12),),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text('专长：外科门诊',
                              style:TextStyle(color: Color.fromARGB(255, 101, 104, 127),fontSize: 12) ,),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            height: 87,
                            width: 80,
                            margin: EdgeInsets.only(left: 50,right: 10),
                            child: IconButton(icon: Image(image: AssetImage("images/icons/3x/follow.png"),width: 87,height: 123,), onPressed: null),
                          ),)

                      ],
                    ),
                  ),
                  Container(
                   // margin: EdgeInsets.only(left: 20,right: 20,top: 5),
                    child: Text('你这种情况应该是坐的时间太长了，你需要多活动活动，如果还是很疼的话建议来医院看看',
                        style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),fontSize: 15,),),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(icon: Image(image:AssetImage("images/icons/3x/Telephone.png"),),
                        onPressed: (){},),
                      Text('和医生电话沟通', style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),fontSize: 15,),)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text('点击填写详细信息，向该医生付费咨询',style: TextStyle(color:Color.fromARGB(255, 101, 104, 127),fontSize: 15,),),
                  )
                ],
              ),
            ),
          )

  ],)
      ,
      );
  }
}
