
import 'package:flutter/material.dart';


class DefaultScaffold extends StatefulWidget {
  
  static const routeName = '/';
  final body;
  final floatingActionButton;
  final title;
  final changer;
  final state;
DefaultScaffold({Key key, @required this.body, this.floatingActionButton, this.title, this.changer, this.state}) : super(key: key);

  
  @override
  _DefaultScaffoldState createState() => _DefaultScaffoldState();
}

class _DefaultScaffoldState extends State<DefaultScaffold> {



  
  final items = List<Map>.generate(200, (i) {
    return {
      'title': 'Journal Entry $i',
      'subtitle': 'Subtitle text for $i',
    };
  });

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
 
        title: Text(widget.title),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 50,
              child: DrawerHeader(
                child: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Row(children: <Widget>[
              Align(alignment: Alignment.bottomLeft, child: Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.bold))),
              Align(alignment: Alignment.bottomRight, 
                child: Switch(value: widget.state, 
                  onChanged: (value) {

                    widget.changer(value); 
                     }))
            ],)
          ],
        )
      ),
      floatingActionButton: hasFloatingActionButton(),
      body: widget.body,
    );
  }

  hasFloatingActionButton() {
    return widget.floatingActionButton ?? Container();
  }

  void newEntryPage(BuildContext context) {
    Navigator.of(context).pushNamed('addForm');
  }
}
