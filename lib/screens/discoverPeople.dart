import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DiscoverPeople extends StatelessWidget {

  // Future getAllPerson()async{
  //   List<GetAllUser> _alluser = [];
  //   Firestore.instance.collection.
  // }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Colors.white,
      body:StreamBuilder<QuerySnapshot>(
       stream:Firestore.instance.collection("users").snapshots(),
       builder:(BuildContext context ,AsyncSnapshot <QuerySnapshot>snapshot){
         if(snapshot.hasError)
           return Center(child: Text("${snapshot.error}"));
           switch (snapshot.connectionState){
             case ConnectionState.waiting: return Center(child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            backgroundColor: Colors.white,
          ));
             default:
             return ListView.builder(
               itemCount: snapshot.data.documents.length,
               itemBuilder: (BuildContext context, int index) {
                  var username = snapshot.data.documents[index]['username'];
                  var name = snapshot.data.documents[index]['name'];
                  var surname = snapshot.data.documents[index]['surname'];
                  //var uid = snapshot.data.documents[index]['uid'];
                  var imgUrl = snapshot.data.documents[index]['imgUrl'];
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   width: width/1.7,
                   child: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Row(children: <Widget>[
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                        Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:imgUrl ==null? AssetImage("assets/Images/user.png"): NetworkImage(imgUrl)
                              )
                            ),
                          )
                       ],),
                       SizedBox(width: 10,),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                         Text("$name $surname",
                         style: TextStyle(
                           color: Colors.black87,
                           fontWeight: FontWeight.w600,
                           fontSize: 17
                           ),),
                           SizedBox(height: 2,),
                           Text("Username: $username",
                         style: TextStyle(
                           color: Colors.black87,
                           //fontWeight: FontWeight.w600,
                           fontSize: 13
                           ),)
                       ],),
                       Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: null,//send friend request
                               child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("assets/Images/contact.png")
                                      )
                                    )
                                  ),
                              )
                            ],),
                       )
                     ],),
                   ),
                 ),
               );
              },
             );
           }
       }
     )
    );
  }
}

// class GetAllUser{
//   final string username;
//   final string name;
//   final string surname;
//   final string bio;
//   final string userImageUrl;
//   GetAllUser(this.username,this.name,this.surname,this.bio,this.userImageUrl);
// }