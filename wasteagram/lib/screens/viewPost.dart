import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/semantics.dart';
import '../widgets/photoBox.dart';
import '../models/postData.dart';
import '../models/dateFormat.dart';


class ViewPost extends StatefulWidget {

  final DocumentSnapshot snapshot;

  ViewPost({Key key, this.snapshot}): super(key:key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {

  Post post;

  @override
  void initState() {
    super.initState();
    post = Post.fromSnapshot(snapshot: this.widget.snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child:  AppBar(centerTitle: true,
                title: Text('Wasteagram'),
                  )
                ),
      body: Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth < 550 ? 
              VerticalLayout(post: post) : HorizontalLayout(post: post);  
          }
        )
      )
    );
  } 
}

class HorizontalLayout extends StatelessWidget {
  const HorizontalLayout({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DetailPageFrame(post: post, padding: 18.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DateHeading(post: post),
            ItemQuantity(post: post),
            LocationDisplay(post: post),
          ],
        ),
      ],
    );
  }
}

class VerticalLayout extends StatelessWidget {
  const VerticalLayout({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DateHeading(post: post),
        DetailPageFrame(post: post),
        ItemQuantity(post:post),
        LocationDisplay(post: post)
      ],
    );
  }
}

class DetailPageFrame extends StatelessWidget {
  const DetailPageFrame({
    Key key,
    @required this.post,
    this.padding = 40.0,
  }) : super(key: key);

  final Post post;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return semanticImage(
      child: AspectRatio(
        aspectRatio: 1/1,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: post.imageUrl != null ? CachedNetworkImage(
            imageUrl: post.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: photoBox(imageProvider)
            ),
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(90),
              child: CircularProgressIndicator(),
            ),
          ) : Container (),
        ),
      ),
    );
  }
}

class DateHeading extends StatelessWidget {
  const DateHeading({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: semanticHeader(
        child: Text(
          dateTimeToString(post.date),
          style: TextStyle(fontSize: 18)
        ),
      ),
    );
  }
}


class LocationDisplay extends StatelessWidget {
  const LocationDisplay({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: semanticLocation(
        child: Text(
          '( ${post.latitude},  ${post.longitude} )',
          style: TextStyle(fontSize: 18) 
        ),
      ),
    );
  }
}

class ItemQuantity extends StatelessWidget {
  const ItemQuantity({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${post.quantity} Items',
      style: TextStyle(fontSize: 18) 
    );
  }
}