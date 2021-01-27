import 'package:chatapp/methods/getUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<bool> checkUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool login = prefs.getBool('login');
  return login;
}

Future<bool> isFirstTime() async {
  // check if the user is verified
  String uid= await getCurrentUID();
  print(uid);
  var x;
  try{
    x= await Firestore.instance.collection('users').document(uid).get();
    return !x.exists;
  }catch(_){
     throw _;
  }
  // if(x.data['verified']==null||x.data['verified']==false)
  // {
  //   return true;
  // }
  // else
  //   return false;
}

//  final databaseReference = Firestore.instance;

//  void setData(var uid)async{
//     await databaseReference.collection('users')
//     .document(uid)
//     .setData({
//       'uid': uid,
//       'verified':false,
//     });
//   }

  //538421
