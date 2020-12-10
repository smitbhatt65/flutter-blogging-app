import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  String _myValue;
  String url;
  //var ImageUrl;
  final formKey = new GlobalKey<FormState>();


  Future getImage() async
  {
    //var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    final _picker = ImagePicker();
    	
    PickedFile tempImage = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(tempImage.path);

    setState(() {
      sampleImage = file;
    });
  }


  bool validateAndSave()
  {
    final form = formKey.currentState;

    if(form.validate())
    {
      form.save();
      return true;

    }
    else
    {
      return false;
    }
  }

  void uploadStatusImage() async
  {
    if(validateAndSave())
    {
      FirebaseStorage storage = FirebaseStorage.instance;

      final Reference postImageRef = storage.ref().child("Post images" + DateTime.now().toString());

      //var timeKey = new DateTime.now();

      final UploadTask uploadTask = postImageRef.putFile(sampleImage);

      // final UploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg".putFile(sampleImage));

      // var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      uploadTask.then((res) {
              res.ref.getDownloadURL();
            });
    var ImageUrl=await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();

      url = ImageUrl.toString();

      print("Image Url ="+ url);

      goToHomePage();

      saveToDatabase(url);


    }

  }

  void saveToDatabase(url)
  {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d,yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = 
    {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time,
    };

    ref.child("Posts").push().set(data);
  }

void goToHomePage()
{
  Navigator.push
  (context,
   MaterialPageRoute(builder: (context)
   {
     return new HomePage();

   }
   )
   );
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold
    (
      appBar: new AppBar
      (
        title: new Text("Upload Image"),
        centerTitle: true,
      ),

      body: new Center
      (
        child: sampleImage == null ? Text("Select an Image") : enableUpload(),
      ),

      floatingActionButton: new FloatingActionButton
      (onPressed: getImage,
      tooltip: 'Add Image',
      child: new Icon(Icons.add_a_photo),
      ),
      
    );
  
  }

  Widget enableUpload()
{
  return new Scaffold
  (
    resizeToAvoidBottomPadding: true,
    body : new Container(
    child: new Form
    (
      
      key: formKey  ,
      child: ListView
      (
        children:<Widget>
        [
          Image.file(sampleImage, height: 330.0, width: 660.0,),

          SizedBox(height: 15.0,),

          TextFormField
          (
            decoration: new InputDecoration(labelText: 'Description'),

            validator: (value)
            {
              return value.isEmpty ? 'Blog Description required' : null;
            },

            onSaved: (value)
            {
              return _myValue = value;
            },
          ),
          SizedBox(height: 15.0,),
          RaisedButton
          (
            elevation: 10.0,
            child: Text('Add a new Post'),
            textColor: Colors.white,
            color: Colors.red,
            onPressed: uploadStatusImage,
          ),
        ],

      ),

    ),
    ),
  
  );
  
}


}

