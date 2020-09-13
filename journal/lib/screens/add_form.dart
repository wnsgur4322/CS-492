import "package:flutter/material.dart";
import "../widgets/journal_entry_form.dart";
import "../widgets/default_scaffold.dart";

class AddForm extends StatelessWidget {
  static const routeName = 'addForm';
  final title = 'Add New Entry';
  final changer;
  final state;

  AddForm({Key key, this.changer, this.state}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final journalChanger = ModalRoute.of(context).settings.arguments;
    return DefaultScaffold(  
      changer: changer,
      state: state,   
      title: title, 
      body: JournalEntryForm(changer: journalChanger),
    );   
  }
}