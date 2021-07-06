import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogs_firebase/services/crud.dart';
import 'package:flutter_blogs_firebase/views/create_blog.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  CRUDmethods crudMethods = new CRUDmethods();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('blogs');

  Widget BlogsList() {
    return Container(
        child: Column(
      children: <Widget>[
        StreamBuilder(
          stream: collectionReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              children: snapshot.data!.docs.map((document) {
                return BlogsTile(
                  authorName: document['authorName'],
                  title: document['title'],
                  description: document['desc'],
                  imgUrl: document['imageUrl'],
                );
              }).toList(),
            );
            // return ListView.builder(
            //     padding: EdgeInsets.symmetric(horizontal: 16),
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return BlogsTile(
            //         authorName: document['authorName'],
            //         title: document['title'],
            //         description: document['desc'],
            //         imgUrl: document['imgUrl'],
            //       );
            //     });
          },
        )
      ],
    ));
  }

  // @override
  // void initState() {
  //   crudMethods.getData().then((result) {
  //     setState(() {
  //       blogsStream = result;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22, color: Colors.pinkAccent.shade100),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.pink),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlogsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Create_Blog()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;

  BlogsTile(
      {required this.imgUrl,
      required this.title,
      required this.description,
      required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      authorName,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
