import 'package:flutter/material.dart';
import 'package:pdc/Pages/Setup/TopicManagement.dart';

class PublishTopicPage extends StatefulWidget {
  @override
  _PublishTopicPageState createState() => _PublishTopicPageState();
}

class _PublishTopicPageState extends State<PublishTopicPage> {
  bool isChecked = false;
  int groupValue;
  String _selectedType;
  String _selectedTab;
  String _title;
  String _content;

  Widget buildTextField(int maxLine) {
    return Theme(
      data: new ThemeData(primaryColor: Color.fromARGB(255, 240, 123, 135), hintColor:Color.fromARGB(255, 249, 223, 221) ),
      child: TextField(
        maxLines: maxLine,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }
  List<DropdownMenuItem> generateItemList() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem item1 = new DropdownMenuItem(
        value: '内科', child: new Text('内科'));
    DropdownMenuItem item2 = new DropdownMenuItem(
        value: '外科', child: new Text('外科'));
    DropdownMenuItem item3 = new DropdownMenuItem(
        value: '五官科', child: new Text('五官科'));
    DropdownMenuItem item4 = new DropdownMenuItem(
        value: '儿科', child: new Text('儿科'));
    DropdownMenuItem item5 = new DropdownMenuItem(
        value: '皮肤科', child: new Text('皮肤科'));
    DropdownMenuItem item6 = new DropdownMenuItem(
        value: '中医科', child: new Text('中医科'));
    DropdownMenuItem item7 = new DropdownMenuItem(
        value: '妇产科', child: new Text('妇产科'));
    DropdownMenuItem item8 = new DropdownMenuItem(
        value: '其他', child: new Text('其他'));
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
    items.add(item5);
    items.add(item6);
    items.add(item7);
    items.add(item8);
    return items;
  }

  var selectItemValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ) ,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.publish),
            color: Color.fromARGB(255, 240, 123, 135),
            tooltip: '发布',
            onPressed: () {
              // handle the press
              publish(_title, _content);
            },
          ),
        ],
      ),

       body: SingleChildScrollView(
         child: Container(
            //color: Colors.black26,
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30,top: 5, bottom: 5),
                  child: Text(
                    "请选择发布类型：",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, bottom: 5,right: 30),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 150,
                        padding: EdgeInsets.all(0),
                        child: RadioListTile<int>(
                            title: Text('帖子',
                                style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),
                                    fontSize: 16,fontWeight: FontWeight.w500)),
                            value: 1,
                            groupValue: groupValue,
                            onChanged: (int e)=>updateGroupValue(e),
                            activeColor: Color.fromARGB(255, 240, 123, 135)
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: RadioListTile<int>(
                            title: const Text('问题',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 69, 69, 92),
                                    fontSize: 16,fontWeight: FontWeight.w500)
                            ),
                            value: 2,
                            groupValue: groupValue,
                            onChanged: (int e)=>updateGroupValue(e),
                            activeColor: Color.fromARGB(255, 240, 123, 135)
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30,top: 5,bottom: 5),
                  child: Text(
                    "请选择疾病标签：",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: new DropdownButton(
                    elevation: 2,
                    hint: new Text('     选择疾病类别      '),
                    value: selectItemValue,
                    items: generateItemList(),
                    onChanged: (T){
                      setState(() {
                        selectItemValue=T;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30,top: 5),
                  child: Text(
                    "题目：",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 30,right: 30,bottom: 5, top: 5),
                    child: Theme(
                      data: new ThemeData(primaryColor: Color.fromARGB(255, 240, 123, 135), hintColor:Color.fromARGB(255, 249, 223, 221) ),
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onChanged: (value){
                          setState(() {
                            _title = value;
                          });
                        },
                      ),
                    ),

                ),
                Container(
                  margin: EdgeInsets.only(left: 30,top: 5),
                  child: Text(
                    "内容：",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                      margin: EdgeInsets.only(left: 30,right: 30,bottom: 5, top: 5),
                      child: Theme(
                        data: new ThemeData(primaryColor: Color.fromARGB(255, 240, 123, 135), hintColor:Color.fromARGB(255, 249, 223, 221) ),
                        child: TextField(
                          maxLines: 15,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (value){
                            setState(() {
                              _content = value;
                            });
                          },
                        ),
                      ),
                  ),
                ),

              ],
            ),
          ),
       ),



    );
  }
  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled){
    return <Widget>[
      SliverAppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ) ,
        pinned: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.publish),
            color: Color.fromARGB(255, 240, 123, 135),
            tooltip: '发布',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      )

    ];
  }

  void updateGroupValue(int e){
    setState(() {
      groupValue=e;
    });
  }

  publish(String title, String content){
    if(groupValue == 0 || selectItemValue == null || title == null || content == null){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('提示'),
            content: Text(('请正确输入全部内容')),
            actions: <Widget>[
              new FlatButton(
                child: new Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }else{
      //select Tabs
      _selectedTab = selectItemValue;
      //select type
      if(groupValue == 1){
        _selectedType = 'Topic';
        TopicManagement().storeNewTopic(_selectedType, _selectedTab, title, content,context);
      }else{
        _selectedType = 'Questions';
        TopicManagement().storeNewQuestion(_selectedType, _selectedTab, title, content,context);
      }


    }

  }
}
