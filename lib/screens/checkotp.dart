import 'package:chatapp/methods/checkUser.dart';
import 'package:chatapp/methods/handleOTP.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chatapp/screens/createprofile.dart';
import 'dart:async';

class CheckOTP extends StatefulWidget {
  @override
  _CheckOTPState createState() => _CheckOTPState();
}

class _CheckOTPState extends State<CheckOTP> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String status;

  Timer _timer;
  var second = 0;
  var minute = 0;
  var resendButtonVisible = false;
  String showTime = "";

  @override
  void initState() {
    super.initState();
    startTimer();
  }


  void startTimer(){
    const oneSec = const Duration(seconds:1);
    _timer = new Timer.periodic(oneSec, (timer) => setState((){
        if(showTime == "1:30"){
          timer.cancel();
          resendButtonVisible = true;
        }else{
          showTime = minute.toString() + ":" + second.toString().padLeft(2,'0');
          second++;
          if(second == 60){
            minute++;
            second = 0;
          }
        }
      })
     );
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
          body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              SizedBox(height: 15,),
             Container(
               height:height/3.5,
               width: width/1.2,
               child:SvgPicture.asset(
                      'assets/Images/undraw_authentication_fsn5.svg',
                      fit: BoxFit.fitHeight,

                    ),
             ),
             SizedBox(height: 15,),
             Text("Enter OTP",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("We have sent  OTP  to your Phone\nNumber for Verification",
              textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 15),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                    child: PinCodeTextField(
                      controller: _controller,
                      onChanged: (String value) {  },
                      length: 6,
                      textStyle: TextStyle(color:Colors.black,fontSize: 23),
                      backgroundColor: Colors.transparent,
                      autoValidate: true,
                      validator:  (value) {
                        if (value.isEmpty) {
                          return "Verification code can't be empty";
                        }
                        return null;
                      },
                    )
                  ),
              ),
                SizedBox(height:30),
                Builder(
                builder: (BuildContext context) {
                   return  RaisedButton(
                    elevation: 12,
                    //color: Color(0xFF7B51D3),
                    color: Color.fromARGB(255, 230, 69, 41),
                    onPressed:(){
                        _validate(_formKey, _controller, context);
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: width/1.2,
                      child: Text("Verify OTP",style: TextStyle(
                        letterSpacing: 1,fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                    ),
                  );
                }),
                SizedBox(height: 15,),
                Text("Didn't Receive the OTP? ",style: TextStyle(color: Colors.black,fontSize: 16),),
                SizedBox(height: 5,),
                Text(showTime,style: TextStyle(color: Color.fromARGB(255, 230, 69, 41),fontSize: 16,fontWeight: FontWeight.bold,letterSpacing: 1),),
                SizedBox(height: 15,),
                InkWell(
                  onTap: () {
                    if(resendButtonVisible)
                      Navigator.pop(context);
                    },
                  child: Text("Resend Code",style: TextStyle(color: resendButtonVisible?Color.fromARGB(255, 230, 69, 41):Colors.transparent,fontSize: 18,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      );
  }
  void _validate(
      GlobalKey<FormState> formKey, TextEditingController controller,context) async {
    if (formKey.currentState.validate()) {
      bool verified = await signInWithPhoneNumber(controller.text);
      if (!verified) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Code is not valid :(")));
      } else {
      bool firstTime = await isFirstTime();
        if(firstTime)
        //If first time user then create a profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreateProfile()),
        );
        else
        print("no");
        // if not then navigate to his home screen
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
      }
    }
  }



}