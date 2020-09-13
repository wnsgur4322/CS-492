import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';


import '../widgets/semantics.dart';
import '../widgets/photoBox.dart';
import '../models/postData.dart';



class AddPost extends StatefulWidget {

  final File imageFile;

  AddPost({Key key, this.imageFile}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  Post post;
  Image image;

  LocationData locationData;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
    image = Image.file(this.widget.imageFile);
    post = Post();
  }

  void retrieveLocation() async {
    var locationService = Location();
    _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  Future<StorageReference> uploadPhotoToStorage() async {
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child(basename(this.widget.imageFile.path));
    StorageUploadTask uploadTask = storageReference.putFile(this.widget.imageFile);
    await uploadTask.onComplete;
    return storageReference;
  }

  void storePostInFirestore(){
    Firestore.instance.collection('posts').add({
      'quantity': post.quantity,
      'date': Timestamp.fromDate(post.date),
      'latitude': post.latitude,
      'longitude': post.longitude,
      'imageUrl': post.imageUrl
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
      centerTitle: true,
      title: Text('New Post'),
        )
      ),
      bottomNavigationBar: uploadButton(context),
      body: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 500 ? 
                VerticalLayout(image: image, formKey: _formKey, post: post) : 
                  HorizontalLayout(image: image, formKey: _formKey, post: post);  
            }
          ),
      )
    );
  }

  Widget uploadButton(BuildContext context) {
    return semanticUploadButton(
      child: GestureDetector(
        child: Container(
          height: 70,
          color: Colors.blue,
          child: Icon(
            Icons.cloud_upload,
            size: 48)
        ),
        onTap: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            StorageReference storageReference = await uploadPhotoToStorage();
            final url = await storageReference.getDownloadURL();

            post.imageUrl = url;
            post.date = DateTime.now();
            post.latitude = locationData?.latitude;
            post.longitude = locationData.longitude;

            storePostInFirestore();

            Navigator.of(context).pop();
          }
        } 
      ),
    );
  }
}

class VerticalLayout extends StatelessWidget {
  const VerticalLayout({
    Key key,
    @required this.image,
    @required GlobalKey<FormState> formKey,
    @required this.post,
  }) : _formKey = formKey, super(key: key);

  final Image image;
  final GlobalKey<FormState> _formKey;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ImageFrame(image: image),
          QuantityForm(formKey: _formKey, post: post)
          ],
        ),
      );
  }
}

class HorizontalLayout extends StatelessWidget {
  
  const HorizontalLayout({
    Key key,
    @required this.image,
    @required GlobalKey<FormState> formKey,
    @required this.post,
  }) : _formKey = formKey, super(key: key);

  final Image image;
  final GlobalKey<FormState> _formKey;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ImageFrame(image: image)
        ),
        Expanded(
          flex: 1,
          child: QuantityForm(formKey: _formKey, post: post),
        )
      ],
    );
  }
}

class QuantityForm extends StatelessWidget {
  const QuantityForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.post,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .7,
      child: Form(
        key: _formKey,
        child: semanticForm(
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Number of wasted items",
              hintStyle: TextStyle(fontSize: 20)
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
            ],
            validator: (value) { 
              if (value.isEmpty) {
                return "Enter a quantity";
              } else if (int.parse(value) < 1) {
                return "Must be greater than 0";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              post.quantity = int.parse(value); 

            } 
          ),
        )
      ),
    );
  }
}

class ImageFrame extends StatelessWidget {
  const ImageFrame({
    Key key,
    @required this.image,
  }) : super(key: key);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return semanticImage(
      child: AspectRatio(
        aspectRatio: 1/1,
        child: Container(
          margin: const EdgeInsets.all(40),
          decoration: photoBox(image.image)
        ),
      ),
    );
  }
}