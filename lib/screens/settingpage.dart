import 'package:chatapp/methods/handleOTP.dart';
import 'package:chatapp/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      title:Text("Settings",style: TextStyle(color:Colors.black),),
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color:Colors.black
      ),
    ),
      body:Column(children: <Widget>[
        SizedBox(height:10),
        Material(
          elevation: 3,
          child: ListTile(
          enabled: true,
          leading:Icon(Icons.remove,color:Colors.black54,),
          title: Text("Logout",
          textScaleFactor: 0.8,
          ),
          trailing: Icon(Icons.arrow_right,color:Colors.black54,),
          onTap:()=> {
            signOut(),
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){return LoginScreen();}))
          },
          ),
        ),
        SizedBox(height:10),
      ],)
    );
  }
}