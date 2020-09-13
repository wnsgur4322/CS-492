import "package:flutter/material.dart";
import "../widgets/journal_entry_display.dart";
import "../widgets/default_scaffold.dart";
import "../models/journal_entry.dart";

class Entry extends StatelessWidget {
  static const routeName = 'addForm';
  final changer;
  final state;
  final data;
  
  Entry({Key key, this.changer, this.state, this.data}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return DefaultScaffold(  
      changer: changer,
      state: state,   
      title: data.date, 
      body: JournalEntryDisplay(data: data),
    );   
  }
}