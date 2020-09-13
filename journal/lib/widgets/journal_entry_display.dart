import "package:flutter/material.dart";

class JournalEntryDisplay extends StatelessWidget {

  final data;

  JournalEntryDisplay({Key key, this.data}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(data.title, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        Text(data.body, style: TextStyle(fontSize: 16)),
        //Text(data.rating.toString()),
      ],
    );
  }

}