import 'package:chatapp/methods/getUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<bool> createProfile(
    String username,String name,String surname,String bio,
    String dob, String gender,
    List<Map<String, dynamic>> hobbies, var imageFile ) async {

    String uid= await getCurrentUID();
    final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://chatapp-629e0.appspot.com");
    StorageUploadTask _uploadTask;
    bool done;
    List hobbiesList=[];
    hobbies.forEach((element) {
      hobbiesList.add(element['title']);
    });
    String path = 'images/${uid}.png';

    _uploadTask =  _storage.ref().child(path).putFile(imageFile);

    var ref = FirebaseStorage.instance.ref().child('images/${uid}.png');

    var imgUrl = await ref.getDownloadURL().then((value) => {
      Firestore.instance.collection('users').document(uid).setData(
      {
        'username':username,
        'name':name,
        'surname':surname,
        'bio':bio,
        'dob':dob,
        'gender':gender,
        'hobbies':hobbiesList,
        'verified':true,
        'bluetick':false,
        'uid': uid,
        'imgUrl': value,
      },
        merge: true
    ),
    done = true
    });
  return done;

}

Future pushImage() async{

}
