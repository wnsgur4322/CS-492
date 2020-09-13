import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'centered_placeholder.dart';


class BusinessCard extends StatefulWidget {
  static const route = '/business_card';
 
  @override
  _BusinessCard createState() => _BusinessCard();
}

class _BusinessCard extends State<BusinessCard> {
  final String name = 'Junhyeok Jeong';
  final String job = 'Developer Extraordinaire';
  final String phone = '541 908 9282';
  final String github = 'github.com/wnsgur4322';
  final String email = 'jeongju@oregonstate.edu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CenteredPlaceholder(left: 150, top: 20, right: 150, bottom: 0),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: banner(context)),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: banner2(context)),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: InkWell(
                onTap: _textMe,
                child: banner3(context)),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: _hyperlink,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: banner4(context))
                  ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: banner5(context))
              ],))
          ]
        )
      )
    );
  }
  Widget banner(BuildContext context) {
    return Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }
  Widget banner2(BuildContext context) {
    return Text(job, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17));
  }
  Widget banner3(BuildContext context) {
    return Text(phone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17));
  }
  Widget banner4(BuildContext context) {
    return Text(github, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12));
  }
  Widget banner5(BuildContext context) {
    return Text(email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12));   
  }
}

  _hyperlink() async {
    const link = "https://github.com/wnsgur4322";
    if (await canLaunch(link)) {
      launch(link);
    } else {
      throw 'Could not Launch $link';
    }
  }

  _textMe() async {
      // Android
      const uri = 'sms:+1 541 908 9282?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        // iOS
        const uri = 'sms:1541-908-9282';
        if (await canLaunch(uri)) {
          await launch(uri);
        } else {
          throw 'Could not launch $uri';
        }
      }
    }