import 'dart:math';
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdc/Pages/Setup/ProgressDialog.dart';
import 'package:pdc/Pages/Setup/UserManagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}



class _SignUpPageState extends State<SignUpPage> {
  String _userName, _email, _password,_photoUrl;
  File sampleImage;
  int groupValue;
  int genderValue;
  bool _loading;
  String _speciality, _technicaltitle;
  var selectItemValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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


  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('image_${Random().nextInt(10000)}.jpg');
    final StorageUploadTask task =
    firebaseStorageRef.putFile(sampleImage);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    setState(() {
      _photoUrl = url;
    });
  }



  @override
  void initState() {
    _loading = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 249, 223, 221),
        elevation: 2,
        title: Text('用户注册',
            style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 18,)),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
        child: ProgressDialog(
          loading: _loading,
          msg: '加载中',
          alpha: 0.4,
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 10),
                      child: Center(
                      child: sampleImage == null?
                        CircleAvatar( backgroundImage:NetworkImage('https://firebasestorage.googleapis.com/v0/b/pdcommunication-89332.appspot.com/o/Oval.png?alt=media&token=1499845b-e07c-484d-b749-b57c6e57279d'),
                        radius: 40.0,):  CircleAvatar( backgroundImage: FileImage(sampleImage),
                        radius: 40.0,)
                ),
                    ),
                    Center(
                      child: RaisedButton(
                        highlightColor: Colors.transparent,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6.0))),
                        color: Color.fromARGB(255, 249, 223, 221),
                        onPressed: (){
                          getImage();
                        },
                        child: Text('上传头像', style: TextStyle(
                          color: Color.fromARGB(255, 69, 69, 92),
                        ),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
                      child: TextFormField(
                        validator: (input) {
                          if(input.isEmpty){
                            return '请输入用户名';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: '用户名'
                        ),
                        onSaved: (input) => _userName = input,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
                      child: TextFormField(
                        validator: (input) {
                          if(input.isEmpty){
                            return '请输入注册邮箱';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: '邮箱'
                        ),
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
                      child: TextFormField(
                        validator: (input) {
                          if(input.length < 6){
                            return '请输入至少为6位的密码';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: '密码'
                        ),
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 0),
                      child: Text('请选择身份：', style: TextStyle(
                        color:  Color.fromARGB(255, 69, 69, 92),fontSize: 18,
                      )),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 150,
                          padding: EdgeInsets.all(0),
                          child: RadioListTile<int>(
                              title: Text('医生',
                                  style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),
                                      fontSize: 16,fontWeight: FontWeight.w500)),
                              value: 1,
                              groupValue: groupValue,
//                              onChanged: (int e)=>updateGroupValue(e),
                              onChanged: (int e){
                                updateGroupValue(e);
                                showDialog(
                                    context: context,
                                    builder: (context){

                                      return AlertDialog(
                                        title: Text('输入信息'),
                                        content: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 0),
                                                child: Text('请输入专长：', style: TextStyle(
                                                  color:  Color.fromARGB(255, 69, 69, 92),fontSize: 18,
                                                )),
                                              ),
                                              Theme(
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
                                                      _speciality = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 0),
                                                child: Text('请输入职称：', style: TextStyle(
                                                  color:  Color.fromARGB(255, 69, 69, 92),fontSize: 18,
                                                )),
                                              ),
                                              Theme(
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
                                                      _technicaltitle = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 30,top: 5,bottom: 5),
                                                child: Text(
                                                  "请选择科室：",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),fontSize: 16),
                                                ),
                                              ),
                                              StatefulBuilder(
                                                builder:  (context, StateSetter setState) {
                                                  return Container(
                                                    margin: EdgeInsets.only(left: 30),
                                                    child: new DropdownButton(
                                                      elevation: 2,
                                                      hint: new Text('     选择职业科室      '),
                                                      value: selectItemValue,
                                                      items: generateItemList(),
                                                      onChanged: (T){
                                                        setState(() {
                                                          selectItemValue = T;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                },

                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text("取消"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          new FlatButton(
                                            child: new Text("确定"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              activeColor: Color.fromARGB(255, 240, 123, 135)
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child: RadioListTile<int>(
                              title: const Text('病人',
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
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 0),
                      child: Text('请选择性别：', style: TextStyle(
                        color:  Color.fromARGB(255, 69, 69, 92),fontSize: 18,
                      )),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 150,
                          padding: EdgeInsets.all(0),
                          child: RadioListTile<int>(
                              title: Text('男',
                                  style: TextStyle(color: Color.fromARGB(255, 69, 69, 92),
                                      fontSize: 16,fontWeight: FontWeight.w500)),
                              value: 1,
                              groupValue: genderValue,
                              onChanged: (int e)=>updateGenderValue(e),
                              activeColor: Color.fromARGB(255, 240, 123, 135)
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child: RadioListTile<int>(
                              title: const Text('女',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 69, 69, 92),
                                      fontSize: 16,fontWeight: FontWeight.w500)
                              ),
                              value: 2,
                              groupValue: genderValue,
                              onChanged: (int e)=>updateGenderValue(e),
                              activeColor: Color.fromARGB(255, 240, 123, 135)
                          ),
                        ),


                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: RaisedButton(
                          highlightColor: Colors.transparent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6.0))),
                          color: Color.fromARGB(255, 249, 223, 221),
                          onPressed: (){
                            signUp(_photoUrl,groupValue,genderValue,selectItemValue);

                          },
                          child: Text('注册',style: TextStyle(
                            color: Color.fromARGB(255, 69, 69, 92),
                          ),),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }


  Future<void> signUp(String _photoUrl, int groupValue, int genderValue, String selectItemValue) async{
    if(_formKey.currentState.validate()){
      setState(() {
        _loading = !_loading;
      });
      _formKey.currentState.save();
      try{
        var _auth = FirebaseAuth.instance;
        String avatar;
        String gender;
        final FirebaseUser user =
        await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        //get avatar
        if(groupValue != null){
          if(groupValue == 1){
            avatar = 'doctor';
            if(_speciality == null || _technicaltitle == null || selectItemValue == null){
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
              setState(() {
                _loading = !_loading;
              });
              return;
            }
          }else{
            avatar = 'normal';
          }
        }else{
          avatar = 'undifine';
        }
        //get gender
        if(genderValue != null){
          if(genderValue == 1){
            gender = '男';
          }else{
            gender = '女';
          }
        }else{
          gender = 'undifine';
        }
          var userUpdateInfo = new UserUpdateInfo();
          userUpdateInfo.displayName = _userName;
          userUpdateInfo.photoUrl = _photoUrl;
          user.updateProfile(userUpdateInfo).then((user){
            FirebaseAuth.instance.currentUser().then((user){
              if(avatar == 'normal'){
                UserManagement().storeNewUser(user, context, avatar,gender );
              }else{
                UserManagement().storeNewDoctor(user, context, avatar, gender, _speciality, _technicaltitle, selectItemValue);
              }

            }).catchError((e){
              print(e);
            });
          }).catchError((e){
            print(e);
          });
          setState(() {
            _loading = !_loading;
          });
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('提示'),
              content: Text((e.message)),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
        setState(() {
          _loading = !_loading;
        });
        return;

      }

    }

  }
  void updateGroupValue(int e){
    setState(() {
      groupValue = e;
    });
  }
  void updateGenderValue(int e){
    setState(() {
      genderValue = e;
    });
  }
}
