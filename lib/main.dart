import 'package:chatapp/screens/createprofile.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let'sChat",
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'GoogleSans',
        canvasColor: Colors.white,
        primaryIconTheme: IconThemeData(color: Colors.black),
        pageTransitionsTheme: PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),
     home: SplashScreen(),
     //home:HomePage(),
    );
  }
}

