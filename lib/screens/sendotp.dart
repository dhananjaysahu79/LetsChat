import 'package:chatapp/methods/handleOTP.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:chatapp/screens/checkotp.dart';
class SendOTP extends StatefulWidget {
  SendOTP({Key key}) : super(key: key);

  @override
  _SendOTPState createState() => _SendOTPState();
}

class _SendOTPState extends State<SendOTP> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  String _phoneNumber;
  String _phoneIsoCode;
  String _internationalPhoneNumber;
  bool _phoneNumberValid = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
       body: GestureDetector(
         onTap: () {
             FocusScopeNode currentFocus =FocusScope.of(context);
             if(!currentFocus.hasPrimaryFocus){
               currentFocus.unfocus();
             }
           },
          child: Stack(
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
              SizedBox(height: 30,),
                Text("PHONE NUMBER",style: TextStyle(color:Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Enter your phone number we will send\nyou the OTP to verfy you",
                textAlign: TextAlign.center,style: TextStyle(color:Colors.black54,fontSize: 15),),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.all(33.0),
                  child: Container(
                    color: Colors.cyan.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8.0),
                      child: Form(
                        key: _formKey,
                        child: InternationalPhoneInput(
                        initialPhoneNumber: _phoneNumber,
                        showCountryFlags: true,
                        showCountryCodes: true,
                        initialSelection: _phoneIsoCode,
                        enabledCountries: ["+91","+44"],
                        onPhoneNumberChange: _inputChange,
                        decoration: InputDecoration.collapsed(hintText: null)
                      ),
                      ),
                    ),
                  ),
                ),
              Builder(
                builder: (BuildContext context) {
                   return  RaisedButton(
                    elevation: 12,
                    //color: Color(0xFF7B51D3),
                    color: Colors.amber,
                    onPressed:(){
                        FocusScopeNode currentFocus =FocusScope.of(context);
                        currentFocus.unfocus();
                      _validateForm(context);
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: width/1.3,
                      child: Text("SUBMIT",style: TextStyle(
                        letterSpacing: 1,fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                    ),
                  );
                })
               ],
             )
          ],
         ),
       ),
    );
  }


   void _inputChange(
      String number, String internationlizedPhoneNumber, String isoCode) {
    setState(() {
      _phoneIsoCode = isoCode;
      _phoneNumber = number;
      if (internationlizedPhoneNumber.isNotEmpty) {
        _internationalPhoneNumber = internationlizedPhoneNumber;
      }
    });
  }

  void _validateForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      if (_internationalPhoneNumber == null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Phone number is not valid :("))
        );
      } else {
        _phoneNumberValid = true;
        await verifyOTP(_internationalPhoneNumber);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CheckOTP();
          }));
      }
    }
  }

}