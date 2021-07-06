import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blogs_firebase/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Create_Blog extends StatefulWidget {
  @override
  _Create_BlogState createState() => _Create_BlogState();
}

class _Create_BlogState extends State<Create_Blog> {
  late String authorName, title, desc;
  CRUDmethods cruDmethods = new CRUDmethods();
  var _image;
  bool isLoading = false;

  getImagefromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  uploadBlog() async{
    if(_image != null){
      setState(() {
        isLoading = true;
      });
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      Reference firebasestorage = FirebaseStorage.instance.ref().child("blogImages").child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = firebasestorage.putFile(_image);
      var downloadUrl = await (await task).ref.getDownloadURL();
      print("This is url $downloadUrl");
      Map<String , String> map = {
        "imageUrl" : downloadUrl,
        "authorName" : authorName,
        "title" : title,
        "desc" : desc
      };
      cruDmethods.addData(map).then((value) {
        Navigator.pop(context);
      });
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Blogging"),
              Text(
                "Blog",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: (){
                debugPrint("Uploading");
                uploadBlog();
                debugPrint("Uploaded");
              },
              child: Icon(
                Icons.upload,
              ),
            ),
          )
          // Icon(Icons.save),
        ],
      ),
      body: isLoading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: getImagefromGallery,
              child: _image != null
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                          child: Image.file(_image, fit: BoxFit.fill,)),
                    )
                  : Container(
                      // padding: EdgeInsets.all(20),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Icon(Icons.add_a_photo),
                      // margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(children: <Widget>[
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Author Name",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (val) {
                    authorName = val;
                  },
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Blog Title",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (val) {
                    title = val;
                  },
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Blog Description",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (val) {
                    desc = val;
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
