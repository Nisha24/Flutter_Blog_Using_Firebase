import 'package:flutter/material.dart';
import 'package:flutter_blogs_firebase/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogging Blogs',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Home(),
    );
  }
}