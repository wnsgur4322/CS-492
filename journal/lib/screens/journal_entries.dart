import 'package:flutter/material.dart';
import '../widgets/default_scaffold.dart';
import '../db/db_manager.dart';
import '../models/journal_entry.dart';
import '../models/journal.dart';
import "../screens/entry.dart";
import "../widgets/journal_entry_display.dart";


class JournalEntries extends StatefulWidget {
  
  static const routeName = '/';
  final title = 'Journal Entries';
  final changer;
  final state;
  //Journal journal;

  JournalEntries({Key key, this.changer, this.state}) : super(key: key);
  

  @override
  _JournalEntriesState createState() => _JournalEntriesState();
}

class _JournalEntriesState extends State<JournalEntries> {

  Journal journal;

  @override
  void initState() {
    super.initState();
    loadEntries();
  }
  
    loadEntries() async {
    final dbManager = DatabaseManager.getInstance();
    List<JournalEntry> records = await dbManager.entries();
    print("RECORDS " + records.toString());
    if(records.isNotEmpty) { setState( () {journal = Journal(entries: records); }); }
    
    
  }


  final items = List<Map>.generate(200, (i) {
    return {
      'title': 'Journal Entry $i',
      'subtitle': 'Subtitle text for $i',
    };
  });

  @override
  Widget build(BuildContext context) {

    //loadEntries();
 
    return DefaultScaffold(
      state: widget.state,
      changer: widget.changer,
      title: widget.title,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {newEntryPage(context);},
      ),
      body: LayoutBuilder(builder: layoutDecider));
  }

  void newEntryPage(BuildContext context) {
    Navigator.of(context).pushNamed('addForm', arguments: updateJournal);
  }

  void entryPage(BuildContext context, JournalEntry entryData) {

    Navigator.push(context,
      MaterialPageRoute( builder: (context) => Entry(data: entryData) ));

  }

  void updateJournal(entry) {
    journal ??= Journal();
    setState( () {
      journal.addEntry(entry);
    });
  }

  Widget buildList(BuildContext context, cardFunc) {
    return ListView.builder(
      itemCount: journal.entries.length,
      itemBuilder: (context, index){
        return buildEntryCard(context, index, cardFunc);
      });
  }

  Widget buildEntryCard(BuildContext context, index, cardFunc) {
    return GestureDetector(
      child: cardFunc(index),
      onTap: () { entryPage(context, journal.entries[index]); }
    );      
  }

  Widget cardItemSmall(index) {
    return  Card(
        child: ListTile(
          leading: Icon(Icons.book),
          trailing: Icon(Icons.more_horiz),
          title: Text("${journal.entries[index].title}"),
          subtitle: Text('${journal.entries[index].date}'),
        ),
      );
  }

  Widget cardItemLarge(index) {
    return  Card(
          child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
                child: Column( children: <Widget>[
                  Text("${journal.entries[index].title}"),
                  Text('${journal.entries[index].date}'),
                ]),  
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: JournalEntryDisplay(data: journal.entries[index])
            ),
        ],
      ),
    );
  }

Widget dbIsEmpty(context, cardFunc) {
  if(journal == null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.book, size: 124),
          SizedBox(height: 36),
          Text('Click add button to add journal entry', style: TextStyle(fontSize: 24)),
        ],
      ));
  } else {
    return buildList(context, cardFunc);
  }
}

Widget layoutDecider(BuildContext context, BoxConstraints constraints) {
  print("constraints: " + constraints.maxWidth.toString());
  return constraints.maxWidth < 700 ? dbIsEmpty(context, cardItemSmall) : dbIsEmpty(context, cardItemLarge);
}



}
