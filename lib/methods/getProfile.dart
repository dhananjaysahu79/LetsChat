// import 'package:chatapp/methods/getUser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// Future getProfile() async{
//   String uid = await getCurrentUID() ;
//   List<UserData> userData = [];
//   Firestore.instance.collection('users').document(uid).get().then((value) => {
//     userData.add(UserData(value['username']))
//   });
//   return userData;
// }
// class UserData{
//   final String username;
//   UserData(this.username);
// }