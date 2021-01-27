import 'package:chatapp/methods/handleOTP.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chatapp/methods/checkUser.dart';
import 'package:chatapp/screens/sendotp.dart';
import 'package:chatapp/screens/createprofile.dart';
import 'package:chatapp/screens/homepage.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness:Brightness.dark),
    child: Scaffold(
      backgroundColor: Colors.white,
     body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
      Container(
      width:double.infinity,
      height: double.infinity,
      decoration:BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Images/splash_background.png"),
          fit: BoxFit.cover
        ))
        ),
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height/4,
              alignment:Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                width:width/3,
                child: Image.asset("assets/Images/LOGO_FINAL.png")
                ),
              ),
            ),
            SizedBox(height:20),
            Text("Hi There !",textAlign: TextAlign.center,
            style: TextStyle(color:Color(0xFF7B51D3),fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height:70),
            RaisedButton.icon(
              elevation: 12,
              //color: Color(0xFF7B51D3),
              color: Colors.cyan,
              onPressed:()=> _sendConfirmationMail(),
              icon: CircleAvatar(child: FaIcon(FontAwesomeIcons.google)),
              label: Container(
                height: 45,
                alignment: Alignment.center,
                width: width/1.35,
                child: Text("Continue with Google",style: TextStyle(
                  letterSpacing: 1,fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
              ),
             ),
             SizedBox(height:10),
             CircleAvatar(
               backgroundColor: Colors.transparent,
               child: Text("OR"),
             ),
             SizedBox(height:10),
            RaisedButton.icon(
              elevation: 12,
              //color: Color(0xFF7B51D3),
              color: Colors.amber,
              onPressed:()=> _sendOTPCode(context),
              icon: CircleAvatar(child: Icon(Icons.email)),
              label: Container(
                height: 45,
                alignment: Alignment.center,
                width: width/1.3,
                child: Text("Continue with Phone No",style: TextStyle(
                  letterSpacing: 1,fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
              ),
             ),
          ]
        )
      ],
    ),));
  }
   Future<void> _sendConfirmationMail() async {
   bool verified = await signInWithGoogle();
   if(verified)
    {
      bool firstTime=await isFirstTime();
      if(!firstTime)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      else
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>CreateProfile())
        );
     }
    else
      print("login unsucsessful");
  }

  void _sendOTPCode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SendOTP(),
      )
    );
  }
}