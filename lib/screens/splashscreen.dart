import 'dart:io';
import 'package:chatapp/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/screens/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  Future changeScreen() async {
   try{
   final res= await InternetAddress.lookup('google.com');
   if (res.isNotEmpty && res[0].rawAddress.isNotEmpty){
      await Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(
      MaterialPageRoute<Null>(
      builder:(BuildContext context){
      return LoginScreen();
      //return HomePage();
    }));
   });
   }

   } on SocketException catch(_){
      changeScreen();
   }
   }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness:Brightness.dark),
    child:Scaffold(
      backgroundColor:Colors.white,
      body:Container(
        width:double.infinity,
        height:double.infinity,
        alignment:Alignment.center,
        decoration:BoxDecoration(
          image:DecorationImage(
            fit:BoxFit.cover,
            image:AssetImage("assets/Images/splash_background.png")
          )
        ),
        child: Container(
          width: width/2,
          height:100,
          decoration:BoxDecoration(
          image:DecorationImage(
            fit:BoxFit.fitWidth,
            image:AssetImage("assets/Images/LOGO_FINAL.png")
          )
        )
        )
      ),
    ));
  }
}