
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdc/Pages/BottomNavigationBar.dart';
import 'package:pdc/Pages/MainPage.dart';
import 'package:pdc/Pages/Setup/ProgressDialog.dart';
import 'package:pdc/Pages/Setup/SignUp.dart';
import 'package:pdc/Pages/Setup/crud.dart';
import '../Home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      _loading = false;
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 249, 223, 221),
        elevation: 2,
        title: Text('用户登录',
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
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('用户名:',style: TextStyle(
                        color:  Color.fromARGB(255, 69, 69, 92),fontSize: 18,
                      ),),
                      margin: EdgeInsets.only(left: 20,top: 70,bottom: 5,right: 30),
                    ),
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(left: 20,top: 0,bottom: 10,right: 30),
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 240, 123, 135),
                        validator: (input) {
                          if(input.isEmpty){
                            return '请输入正确的邮箱';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.black26
                          ),
                        ),
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Container(
                      child: Text('密码:',style: TextStyle(
                        color:  Color.fromARGB(255, 69, 69, 92),fontSize: 18,
                      ),),
                      margin: EdgeInsets.only(left: 20,top: 10,bottom: 0,right: 30),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,bottom: 30,left: 20,right: 20),
                      child: TextFormField(
                        validator: (input) {
                          if(input.length < 6){
                            return '请输入正确密码';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: TextStyle(
                              color: Colors.black26
                          ),
                        ),
                        onSaved: (input) => _password = input,
                        obscureText: true,
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
                          signIn();
                        } ,
                        child: Text('登录', style: TextStyle(
                          color: Color.fromARGB(255, 69, 69, 92),
                        ),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 200,right: 20,top: 25),
                      child: FlatButton(
                        child: Text('还没有账号？点击这里注册',textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12,color: Color.fromARGB(255, 145, 153, 185)
                          ),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      setState(() {
        _loading = !_loading;
      });
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(user: user)));
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));
        setState(() {
          _loading = !_loading;
        });
      }catch(e){
        print(e);
      }

    }
  }


}