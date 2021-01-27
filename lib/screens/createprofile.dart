import 'dart:io';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:chatapp/methods/getHobbies.dart';
import 'package:chatapp/methods/createProfile.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:chatapp/screens/homepage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key key}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  List<String> _genders = ["Male", "Female", "Gay", "Lesbian", "Bi"];
  final _formKey = GlobalKey<FormState>();
  String _selectedGender;
  List<int> _selectedHobbies = [];
  File _imageFile;

  @override
  Widget build(BuildContext context) {
     var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:Text("Edit Profile",
          textScaleFactor: 0.8,
          style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold)
        ),
        brightness:Brightness.light,
        iconTheme: IconThemeData(
          color:Colors.black
        ),
      ),
       body: SingleChildScrollView(
         physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 15),
                child: Form(
                   key: _formKey,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:Colors.black
                            ),
                          ),
                         _imageFile == null? Container(
                            height: 170,
                            width: 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/Images/user.png")
                              )
                            ),
                          ):
                          Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_imageFile)
                              )
                            ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 170,
                          width: 170,
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(50),
                            child: IconButton(icon: Icon(Icons.edit,color: Colors.black,), onPressed: () => pickImage() )),
                        )
                        ],
                      ),
                      SizedBox(height: 40,),
                      TextFormField(
                        controller: _usernameController,
                        maxLines: 1,
                        cursorColor: Color.fromARGB(255, 230, 69, 41),
                        decoration: InputDecoration(
                            hintText: "Enter a Username here",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                            ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "PLease Enter a Username";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //Name
                          Container(
                          width: width/2.3,
                        child: TextFormField(
                        controller: _nameController,
                        maxLines: 1,
                        cursorColor: Color.fromARGB(255, 230, 69, 41),
                        decoration: InputDecoration(
                              hintText: "Name",
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                              ),
                        validator: (value) {
                            if (value.isEmpty) {
                              return "PLease Enter a Name";
                            }
                            return null;
                           },
                          ),
                        ),
//surname
                       Container(
                         width: width/2.2,
                         child: TextFormField(
                          controller: _surnameController,
                          maxLines: 1,
                          cursorColor: Color.fromARGB(255, 230, 69, 41),
                          decoration: InputDecoration(
                              hintText: "Surname",
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                              ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "PLease Enter a Surname";
                            }
                            return null;
                          },
                          ),
                         ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 100,
                        child: TextFormField(
                          controller: _bioController,
                          maxLength: 120,
                          maxLines: 5,
                          cursorColor: Color.fromARGB(255, 230, 69, 41),
                          decoration: InputDecoration(
                              hintText: "Bio....\nNot more than 120 characters",
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),

                            ),
                           validator: (value) {
                            if (value.isEmpty) {
                              return "PLease Enter a Bio";
                            }
                            else if(value.length> 120){
                              return "Your Bio should not exceed 120 characters";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 5,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Container(
                           width: width/2.3,
                           child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range),
                                hintText: "Date of birth",
                                 focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),
                            ),
                              ),
                              readOnly: true,
                              controller: _ageController,
                              onTap: () => showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now())
                                  .then((value) => {
                                        _ageController.text =
                                            formatDate(value, ["d", "th ", "M", " ", "yyyy"])
                                      }),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "This field can't be empty";
                                }
                                return null;
                              },
                            ),
                         ),
                         Container(
                          alignment: Alignment.bottomCenter,
                          width: width/2.2,
                          height: 65,
                          child: DropdownButton<String>(
                            value: _selectedGender,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 28,
                            elevation: 16,
                            isExpanded: true,
                            hint: Text("Gender",style: TextStyle(color: Colors.black45,fontSize: 18,fontFamily: "GoogleSans"),),
                            style: TextStyle(color: Colors.black,fontSize: 18),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                            items: _genders.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                         )
                       ],
                     ),
                     SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
              FutureBuilder(
                      future: getHobbies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ChipsChoice<int>.multiple(
                            value: _selectedHobbies,
                            options: ChipsChoiceOption.listFrom<int,
                                Map<String, dynamic>>(
                              source: snapshot.data,
                              value: (index, hobbie) => hobbie["value"],
                              label: (index, hobbie) => hobbie["title"],
                            ),
                            onChanged: (val) =>
                                setState(() => _selectedHobbies = val),
                            itemConfig: ChipsChoiceItemConfig(
                              elevation: 6,
                              labelStyle: TextStyle(color: Colors.black),
                              selectedColor: Colors.deepPurpleAccent,
                              unselectedColor: Colors.black,
                              selectedBrightness: Brightness.dark,
                              unselectedBrightness: Brightness.light
                            ),
                            isWrapped: true,
                          );
                        } else {
                          return Text("Hobbies loading ...");
                        }
                      }),
                   SizedBox(height: 25,),
                   Builder(
                    builder: (BuildContext context) {
                       return  RaisedButton(
                        elevation: 12,
                        color: Colors.deepPurpleAccent,
                        onPressed:(){
                             FocusScopeNode currentFocus =FocusScope.of(context);
                             currentFocus.unfocus();
                            _createProfile(context);
                        },
                        child: Container(
                          height: 42,
                          alignment: Alignment.center,
                          width: width/1.3,
                          child: Text("SAVE CHANGES",style: TextStyle(
                            letterSpacing: 1,fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                        ),
                      );
                    }),
                    SizedBox(height: 60,)
            ],
          ),
      )
    );
  }

  Future pickImage() async{
    final selected = await ImagePicker().getImage(source: ImageSource.gallery);
    setState((){
      if(selected != null){
        var _imgFile = File(selected.path);
      _cropImage(_imgFile);
      }
      else
      print("select a file");
    });
  }
  Future<Null> _cropImage(var _imgfile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imgfile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit photo',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
         _imageFile = croppedFile;
      });
    }
  }
  void _createProfile(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      if (_selectedGender == null) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Please select your gender")));
      } else {
        List<Map<String, dynamic>> hobbies = await getHobbies();
        List<Map<String, dynamic>> selectedHobbies = [];
        _selectedHobbies
            .forEach((index) => selectedHobbies.add(hobbies[index]));

        bool profileCreated = await createProfile(
            _usernameController.text,
            _nameController.text,
            _surnameController.text,
            _bioController.text,
            _ageController.text,
            _selectedGender,
            selectedHobbies,
            _imageFile,
            );

        if (profileCreated) {
          print("Profile created successfully");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Oops! something went wrong :( please try again")));
        }
      }
    }
  }
}