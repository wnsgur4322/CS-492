import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../models/journal_entry.dart';



class DatabaseManager {
  
  static const String DB_FILENAME = 'journal.sqlite3.db';
  //static const CREATE = 'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER  NOT NULL, date TEXT NOT NULL)';
  static const CREATE_FILE_PATH = '../assets/schema_1.sql.txt';
  static const SELECT = 'SELECT * FROM journal_entries';
  static const INSERT = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)';

  static DatabaseManager _instance;
  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    //await deleteDatabase(DB_FILENAME);
    //String create = await getCreateQuery();
    final db = await openDatabase(DB_FILENAME,
    version: 1,
    onCreate: (Database db, int version) {
      createTables(db, "CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);");
    });
    _instance = DatabaseManager._(database: db);
  }


  //static Future<String> getCreateQuery() async {
  //  return await rootBundle.loadString(CREATE_FILE_PATH);   
  //}
  static void createTables(Database db, String query) async {
    await db.execute(query);
  }

  void saveEntry({entry}) {
    db.transaction( (txn) async {
      await txn.rawInsert(INSERT, [
        entry.title, entry.body, entry.rating, entry.dateTime
      ]);
    });
  }

  Future<List<JournalEntry>> entries() async {
    final records =  await db.rawQuery(SELECT);
    print ("records from  load" + records.toString());

    List<JournalEntry> entries = records.map( (record) {
      return JournalEntry(
        title: record['title'],
        body: record['body'],
        rating: record['rating'],
        date: record['date']
      );}).toList();

      print("from select " + entries.toString());
      return entries;
  }
}

