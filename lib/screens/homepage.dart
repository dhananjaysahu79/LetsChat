
import 'package:chatapp/methods/getUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/screens/chatlist.dart';
import 'package:chatapp/screens/discoverPeople.dart';
import 'package:chatapp/screens/settingpage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  FirebaseUser user;

  @override
  void initState(){
    getUser();
    super.initState();
  }

 Future getUser()async{
    user = await getCurrentUSER();
    String uid = await getCurrentUID() ;
    List<UserData> userData = [];
    UserData temp;
    final ref = FirebaseStorage.instance.ref().child('images/${uid}.png');
    var url = await ref.getDownloadURL();
    Firestore.instance.collection('users').document(uid).get().then((value) => {
      temp = UserData(value['username'], user.email,url),
      userData.add(temp)
    });
    return userData;
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
     //backgroundColor: Color(0xFF3d3e5c),
     backgroundColor: Colors.white,
     appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title:Container(width: width/3.5,child: Image.asset("assets/Images/LOGO_FINAL.png",fit: BoxFit.cover,)),
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color:Colors.black
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search ,color: Colors.black,), onPressed: null),
        IconButton(icon: Icon(Icons.more_vert ,color: Colors.black,), onPressed: null),

      ],
    ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getUser(),
              builder: (context,snapshot){
               return snapshot.data==null?CircularProgressIndicator() :UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                ),
                currentAccountPicture: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(snapshot.data[0].imageUrl))
                  ),
                  ),
                accountName: Text(snapshot.data[0].username,style: TextStyle(color: Colors.black),),
                accountEmail: Text(snapshot.data[0].email,style: TextStyle(color: Colors.black),));
             }),
               SizedBox(height:10),
               ListTile(
                enabled: true,
                leading:Icon(Icons.account_circle,color:Colors.black54,),
                title: Text("Account",
                  style: TextStyle( fontFamily: "GoogleSans",),
                textScaleFactor: 0.8,
                ),
               onTap:()=> null
               ),
               SizedBox(height:10),
               ListTile(
                enabled: true,
                leading:Icon(Icons.settings,color:Colors.black54,),
                title: Text("Settings",
                  style: TextStyle( fontFamily: "GoogleSans",),
                textScaleFactor: 0.8,
                ),
               onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings(),))
               ),
               SizedBox(height:10),
               ListTile(
                enabled: true,
                leading:Icon(Icons.info_outline,color:Colors.black54,),
                title: Text("About",
                  style: TextStyle( fontFamily: "GoogleSans",),
                textScaleFactor: 0.8,
                ),
               onTap:()=> null
               ),
               SizedBox(height:10),
               ListTile(
                title: Text("Favourites",
                  style: TextStyle( fontSize: 17,),
                textScaleFactor: 0.8,
                ),
               onTap:()=> null
               ),
          ],
        ),
      ),
       bottomNavigationBar:Container(
        height: 50,
        width: double.infinity,
        //color: Color(0xFF22212F),
        color:Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left:18.0,right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.home,color: Colors.black,), onPressed:()=> _pageController.jumpToPage(0)),
              IconButton(icon: Icon(Icons.devices_other ,color: Colors.black,),onPressed:()=> _pageController.jumpToPage(1)),
              IconButton(icon: Icon(Icons.chat_bubble_outline,color: Colors.black,),onPressed:()=> _pageController.jumpToPage(2)),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ChatList(),
          DiscoverPeople(),
        ],
      )
    );
  }
}

class UserData{
  final String username,email,imageUrl;
  UserData(this.username,this.email,this.imageUrl);
}