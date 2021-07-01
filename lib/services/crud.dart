import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDmethods{
  Future<void> addData(blogData) async{
    FirebaseFirestore.instance.collection("blogs").add(blogData).catchError((e){
      print(e);
    });
  }
}