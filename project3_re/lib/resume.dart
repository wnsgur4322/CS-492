import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'resume_contents.dart';

class Resume extends StatefulWidget {
  static const route = '/business_card';

  @override
  _Resume createState() => _Resume();
}

class _Resume extends State<Resume> {
  final String name = 'Junhyeok Jeong';
  final String email = 'jeongju@oregonstate.edu';
  final String github = 'https://github.com/wnsgur4322';

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(10, 30, 0, 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[banner(context)])
                ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[banner3(context)])
                ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: _hyperlink,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: banner2(context))
                    ),
                ],)
              ),
              for (var i = 0; i < 8; i++) ResumeContents(
                title: contentsData['title'][i % 4],
                company: contentsData['company'][i],
                duration: contentsData['duration'][i],
                location: contentsData['location'][i % 5],
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam')
              ]
          ),
        )
      )
    );
  }
  Widget banner(BuildContext context) {
    return Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }
  Widget banner2(BuildContext context) {
    return Text(github, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
  }
  Widget banner3(BuildContext context) {
    return Text(email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15));   
  }
}

var contentsData = {
  'title' : ['Software Engineer', 'Data Scientist', 'Web Designer', 'SWE Intern'],
  'company' : ['Google Inc.', 'Facebook', 'Amazon', 'Netflix', 'Tesla', 'SpaceX', 'Oracle', 'Microsoft'],
  'duration' : ['2012 - 2013', '2013 - 2014', '2014 - 2015', '2015 - 2016', '2016 - 2017', '2017 - 2018', '2018 - 2019', '2019 - Present'],
  'location' : ['Corvallis, OR', 'Mountain View, CA', 'Portland, OR', 'Seattle, WA', 'Los Angeles, CA']
};



_hyperlink() async {
    const link = "https://github.com/wnsgur4322";
    if (await canLaunch(link)) {
      launch(link);
    } else {
      throw 'Could not Launch $link';
    }
  }