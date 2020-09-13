import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/semantics.dart';
import '../models/dateFormat.dart';
import 'addPost.dart';
import 'viewPost.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int totalQuantity;

  final picker = ImagePicker();

  Future getImg() async {
    final pickedFile = await picker.getImage(source:ImageSource.gallery);
    if (pickedFile != null)
      return File(pickedFile.path);
    else
      return null;
  }

  void countQuantity() async {
    int totalCount = 0;
    var snapshot = await Firestore.instance.collection('posts').getDocuments();
    snapshot.documents.forEach((element) {
      totalCount += element['quantity'];
    });
    setState(() {
      totalQuantity = totalCount;
    });

  }

  @override
  Widget build(BuildContext context) {
    countQuantity();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(centerTitle: true,
                title: Text('Wasteagram - $totalQuantity'),
                  )
              ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: semanticCameraButton(
          child: cameraButton(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: StreamBuilder(
        stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
        builder: (content, snapshot) {    
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            return ListView.separated(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var post = snapshot.data.documents[index];
                return semanticPost(
                  child: ListTile(
                    dense: true,
                    title: 
                      Text(dateTimeToString(DateTime.parse(post['date'].toDate().toString())),
                      style: TextStyle(fontSize: 18)),
                    trailing: Text(post['quantity'].toString(), style: TextStyle(fontSize: 18)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewPost(snapshot: post))
                      );
                    },
                    onLongPress: () async {
                      await Firestore.instance.runTransaction((Transaction transaction) async {
                      await transaction.delete(snapshot.data.documents[index].reference);
                      });
                    }
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey
                );
              },
            );
          } else {
            return Center(
              child: semanticLoading(
                child: CircularProgressIndicator()
              )
            );
          }
          
        }
      )
    );
  }

  Widget cameraButton() {
    return FloatingActionButton(
      child: Icon(Icons.camera_alt),
      onPressed: () async {
        File imageFile = await getImg();
        if (imageFile != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPost(imageFile: imageFile))
          );
        }
      }
    );
  }
  
}


