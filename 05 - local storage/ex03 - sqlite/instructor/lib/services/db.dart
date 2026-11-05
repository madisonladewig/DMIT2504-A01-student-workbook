import 'package:sqflite/sqflite.dart';


const dbName = 'todos.db';


// 'get-or-create' kinda situation: if db exists, use it, otherwise create it, return that db instance
// all sqflite interaction is async
Future<Database> getDatabase() async {
  return openDatabase(   // get-or-create db file
    dbName,
    version: 1,          // SQL schema version
    onCreate: (Database db, int version) async {  // onCreate only runs if db needs to be created
      await db.execute('''
        CREATE TABLE todos (
          id INTEGER PRIMARY KEY,
          description TEXT,
          done INTEGER DEFAULT 0
        )
      ''');
      // note: done is not true/false, but an int (we'll use 0/1); sqlite can't do booleans
      // type constraints for sqflite: https://pub.dev/packages/sqflite#supported-sqlite-types
    }
  );
}