import 'package:flutter/material.dart';
import 'package:flutter_blogs_firebase/views/create_blog.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Blogging"),
              Text("Blog", style: TextStyle(color: Colors.black),)
            ],
          ),
        )
      ),
      body: Container(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Create_Blog()));
            },
            child: Icon(Icons.add,size: 50,),)
          ],
        ),
      ),
    );
  }
}
