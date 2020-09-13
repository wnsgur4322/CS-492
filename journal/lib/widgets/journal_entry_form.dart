import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../db/journal_entry_dto.dart';
import '../db/db_manager.dart';
import '../models/journal_entry.dart';
import '../widgets/dropdown_rating_form_field.dart';

class JournalEntryForm extends StatefulWidget {

  final entryFields = JournalEntryDTO(); 
  final entry = JournalEntry();
  final changer;

  JournalEntryForm({Key key, this.changer}) : super(key: key);

  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(children: <Widget>[
          entryField(label: 'title'),
          entryField(label: 'body'),
          DropdownRatingFormField(
            maxRating: 4,
            validator: (value) { if (value == null) {return "Enter a rating";} else { return null;} },
            onSaved: (value) { widget.entryFields.rating = value; }
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            formButton(label: "cancel", color: Colors.grey, pressFunc: () {Navigator.of(context).pop();}),
            formButton(label: "Save", color: Colors.blue, pressFunc: () {  pressedSave();  }),
          ]
      
          )
        ],
        ),
        
      ),
    );
  }

  Widget entryField({label})
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        autofocus: true,
        decoration: InputDecoration(
        labelText: label, border: OutlineInputBorder(),
        ),
      onSaved: (value) {
        switch(label) {
          case('title'): widget.entryFields.title = value; break;
          case('body'): widget.entryFields.body = value; break;
        }
        
      },
      validator: (value) { return isValid(value: value, label: label); }
      ),
    );
  }

  Widget formButton({label, pressFunc, color}) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0, right: 20.0, left: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10.0,
        onPressed: pressFunc,
        child: Text(label, style: TextStyle(color: Colors.white)),
        color: color,
      ),
    );
  }

  String isValid({value, label}) {
    if (value.isEmpty) {
      return "Please enter a $label";
    } else {
      return null;
    }
  }

  void pressedSave() {
    print(formKey.currentState.validate());
    if (formKey.currentState.validate()) {
    addDate();
    final dbManager = DatabaseManager.getInstance(); 
    formKey.currentState.save(); 
    dbManager.saveEntry(entry: widget.entryFields);
    widget.changer(JournalEntry(
      title: widget.entryFields.title,
      body: widget.entryFields.body,
      rating: widget.entryFields.rating,
      date: widget.entryFields.dateTime,
    ));
    Navigator.of(context).pop();
  }
  }

  void addDate() {
    var formatter = DateFormat('EEEE, MMMM d, y');
    widget.entryFields.dateTime = formatter.format(DateTime.now());
  }

}