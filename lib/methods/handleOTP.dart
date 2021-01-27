import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:matmak/methods/FirebaseAdd.dart';
//import 'package:shared_preferences/shared_preferences.dart';
// boolean values are returned to notify the functions are completed
// return false if some error occurred

String status,actualCode;
final FirebaseAuth _auth=FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String email;
String phoneNumber;

void onAuthenticationSuccessful(AuthResult result) async {
  // FirebaseAdd().addUser(result.user.email, result.user.phoneNumber, result.user.uid);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool('login', true);
}

Future<bool> signInWithPhoneNumber(String smsCode) async {

  bool verified =false;

  AuthCredential auth = PhoneAuthProvider.getCredential(verificationId: actualCode, smsCode: smsCode);

     await _auth.signInWithCredential(auth).catchError((error) {
        print("Wrong code entered or Something went wrong!");
       }).then((user) async {
         if(user!=null){
           verified= true;
          print('Authentication successful');
          onAuthenticationSuccessful(user);
        }});

    return verified;

  }

Future<bool> verifyOTP(String phoneNo) async {

  bool verified=false;

  final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
      actualCode = verificationId;
      print("\nEnter the code sent to " + phoneNo);
    };
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) async{
         actualCode = verificationId;
         print("\nAuto retrieval time out");
         verified=false;
    };

  final PhoneVerificationFailed verificationFailed =
      (AuthException authException) async{
       print('Something has gone wrong, please try later');
       verified= false;
    };

  final PhoneVerificationCompleted verificationCompleted =
       (AuthCredential auth) async{
     await _auth
       .signInWithCredential(auth)
       .then((AuthResult value) {
        if (value.user != null) {
          onAuthenticationSuccessful(value);
          verified = true;
          print("Auth successful");
        } else {
          print('Invalid code/invalid authentication');
          verified= false;
       }
      }).catchError((error) {
        print('Something has gone wrong, please try later');
        verified = false;
       });
      };

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: null
      );

      return verified;

  }

Future<bool> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  assert(user.email != null);
  assert(user.displayName != null);
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setBool('login', true);
  email = user.email;
  phoneNumber=user.phoneNumber;
  //FirebaseAdd().addUser(email, phoneNumber, user.uid);
  return true;
}

void signOut() async{
  await googleSignIn.signOut();
  await FirebaseAuth.instance.signOut();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  print("User Sign Out");
}