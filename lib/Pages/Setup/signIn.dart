
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Provide an email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
                onSaved: (input) => _email = input,
              ),
              TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Longer password please';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                onSaved: (input) => _password = input,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signIn,
                child: Text('Sign in'),
              ),
            ],
          )
      ),
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      //TODO login to firebase
      formState.save();
      //try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(user: user)));
      //}catch(e){
       // print(e.details);
     // }

    }
  }

  Future<void> signUp() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(user: user)));
    }

  }
}