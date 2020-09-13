import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import 'resume.dart';
import 'predictor.dart';
import 'business_card.dart';

class TabMenu extends StatefulWidget {
 static const route = '/tab';

 final String pages;

 TabMenu ({this.pages});

 @override
  _TabMenu createState() => _TabMenu();
}

class _TabMenu extends State<TabMenu> {

    List<Widget> _widgets = <Widget>[
    BusinessCard(),
    Resume(),
    Predicator()
  ];


  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Call Me Maybe"),
        backgroundColor: Colors.blueGrey,
        bottom: TabBar(
          tabs: <Tab>[
            Tab(icon: Icon(Icons.face),),
            Tab(icon: Icon(Icons.description),),
            Tab(icon: Icon(Icons.help_outline),)
          ],
        )
      ),
      body: TabBarView(
        children: [
          Center(child: BusinessCard()),
          Center(child: Resume()),
          Center(child: Predicator())
        ],
        )
    );
  }
}