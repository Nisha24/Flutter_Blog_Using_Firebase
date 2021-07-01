import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blogs_firebase/services/crud.dart';
import 'package:image_picker/image_picker.dart';

class Create_Blog extends StatefulWidget {
  @override
  _Create_BlogState createState() => _Create_BlogState();
}

class _Create_BlogState extends State<Create_Blog> {
  late String authorName, title, desc;
  CRUDmethods cruDmethods = new CRUDmethods();
  var _image;

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

  uploadBlog() {
    if(_image != null){
      
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
                uploadBlog()
              },
              child: Icon(
                Icons.upload,
              ),
            ),
          )
          // Icon(Icons.save),
        ],
      ),
      body: Container(
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
