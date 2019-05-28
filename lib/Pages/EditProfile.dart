import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdc/Pages/Setup/ProgressDialog.dart';
import 'package:pdc/Pages/Setup/UserManagement.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key, this.url, this.name}) : super(key: key);
  final String url;
  final String name;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String docId;
  String userId;
  bool _loading;
  String _userName, _email, _password, _photoUrl, _intro;
  File sampleImage;
  int groupValue;
  int genderValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('image_${user.uid}.jpg');
    final StorageUploadTask task =
    firebaseStorageRef.putFile(sampleImage);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    setState(() {
      _photoUrl = url;
    });
    UserManagement().updateProfilePic(_photoUrl);
  }

  @override
  void initState() {
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black26, size: 18,),
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('编辑个人信息', style: TextStyle(
            color: Color.fromARGB(255, 69, 69, 92), fontSize: 18),),
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
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        child: Center(
                            child: sampleImage == null ?
                            CircleAvatar(backgroundImage: NetworkImage(widget
                                .url),
                              radius: 40.0,) : CircleAvatar(
                              backgroundImage: FileImage(sampleImage),
                              radius: 40.0,)
                        ),
                      ),
                      Center(
                        child: RaisedButton(
                          highlightColor: Colors.transparent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  6.0))),
                          color: Color.fromARGB(255, 249, 223, 221),
                          onPressed: () {
                            getImage();
                          },
                          child: Text('上传头像', style: TextStyle(
                            color: Color.fromARGB(255, 69, 69, 92),
                          ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 5),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return '请输入用户名';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: '填写简介'
                          ),
                          onSaved: (input) => _intro = input,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 5),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return '请输入用户名';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: '修改用户名 : ${widget.name}'
                          ),
                          onSaved: (input) => _userName = input,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                          child: RaisedButton(
                            highlightColor: Colors.transparent,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(6.0))),
                            color: Color.fromARGB(255, 249, 223, 221),
                            onPressed: () {
                              updateInfo();
                              Navigator.of(context).pop();
                            },
                            child: Text('提交', style: TextStyle(
                              color: Color.fromARGB(255, 69, 69, 92),
                            ),),
                          ),
                        ),
                      )
                    ],
                  )
              )


          ),
        ),
      ),
    );
  }

  updateInfo() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      setState(() {
        _loading = !_loading;
      });
      formState.save();
      try {
        var userInfo = new UserUpdateInfo();
        userInfo.displayName = _userName;
        FirebaseAuth.instance.currentUser().then((user) {
          user.updateProfile(userInfo).then((val) {
            Firestore.instance.collection('users').where(
                'uid', isEqualTo: user.uid)
                .getDocuments().then((docs) {
              Firestore.instance.document(
                  'users/${docs.documents[0].documentID}')
                  .updateData({
                'displayName': _userName,
                'intro': _intro,
              });
            });
          });
        });

        setState(() {
          _loading = !_loading;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
