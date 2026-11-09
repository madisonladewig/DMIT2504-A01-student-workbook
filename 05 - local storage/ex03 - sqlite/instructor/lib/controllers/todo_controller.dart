/* With sqflite, we are going to use a 'controller', i.e. an object that can do
   CRUD operations on the dbfile.

   More specifically, we're going to implement this in a way where there is only *one*
   db controller at a time in the entire runtime of this app.

   The reason for that is, sqlite is just SQL <---> file, so if we have multiple simultaneous
   instances of this db i/o controller, what might happen is:
      Controller A -> opens file first, prepares write
      Controller B -> also opens file, prepares write
      Controller A -> writes, adds new A entry, closes file
      Controller B -> writes, adds new B entry, *overwrites* A's changes

      If two things open a file at the ~same time, whoever writes last
      will actually write that data, but it will overwrite any changes made by other controllers.

      We'll safeguard against this by using a clever OOP pattern called the singleton.
*/

import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';


class TodoController {

  // static means "the same for all instances"
  // a static method/attr means I can also access it without needing an instance of the class
  // e.g. for a class Dog:
  //   static bark() -> Dog.bark() can be called without needing an instance first
  //   bark()        -> d = Dog() -> d.bark() otherwise
  static Database? _db;
  static TodoController? _instance;   // this will store the (one) instance of this class (that's allowed to exist)
  static const tableName = 'todos';
  // why does that matter here?
  // -> I need a way of calling, from the class directly and *before I make an instance*,
  //    a method to get-or-create a single instance of this controller.

  static TodoController getInstance(Database db) {
    _instance ??= TodoController._internal(db); // "current _instance value if not null, otherwise _instance = (make a new one)"
    return _instance!;
  }

  TodoController._internal(Database db) {
    // ._internal means a *private* constructor.
    // I'm not going to implement a public constructor (that would allow duplicate instance)
    // a private constructor only means "only code within TodoController can make a TodoController() instance"
    _db = db;
  }

  /* Summary of how all the singleton stuff works:@override
      a) there is no public constructor, so no outside code can make new/duplicate instances
      b) I write a getInstance method that creates and returns the ctrler instance if there isn't one,
         or just returns it if there is (stored in this class's _instance attribute)
      c) I make *all* associated methods/values static, so they can be called WITHOUT needing to make an instance first,
         i.e. TodoController.getInstance()  gets-or-creates the *one* TodoController() allowed to exist at a given time

    Further explanation: https://refactoring.guru/design-patterns/singleton
  */

  /* Now for the actual sqflite <---> Todo() CRUD ops! sqflite gives us:

      {db}.query(tableName, args?)  -> read/query
      {db}.update(tableName, args)  -> update a given instance/row
      {db}.insert(tableName, map)   -> add a new instance/row
      {db}.delete(tableName, args?) -> delete (whole table if no args, otherwise selectively delete rows via query args)
  
    Notice that for adding/updating, we're not returning the thing that was jsut added/updated.
    What we'll do instead is, after every write operation (add, update, delete), we will refetch the entire todo list from the 
    backend in the widget. That way, we're only ever writign state to the db, and reading fresh state from the db.
  */
  Future<List<Todo>> getTodos() async {
    // db queries return {key: value} map as well, so I have to ingest that into a Todo() instance.
    final List<Map<String, dynamic>> maps = await _db!.query(tableName);
  
    return List.generate(
      maps.length,                          // arg 1: number of iterations/items, looping counter max
      (i) { return Todo.fromMap(maps[i]); } // arg 2: the callback function to generate a list element for each input element
    );
  }


  Future<void> addTodo(Todo todo) async {
    await _db!.insert(tableName, todo.toMap());
    // note: we're passing {key: value} map of a Todo()'s data, not the instance/object itself
  }

  Future<void> updateTodo(Todo todo) async {
    await _db!.update(
      tableName,     // arg 1: table name
      todo.toMap(),  // arg 2: data to write (so far, same as adding)
      where: 'id = ?', // args 3&4: passing a {WHERE id ==} to single out a specific row
      whereArgs: [todo.id],  //TLDR: where+whereArgs avoids SQL injection, rather than just {where 'id = todo.id'} 
    );
  }

  Future<void> deleteAllTodos() async {
    await _db!.delete(tableName);  // deletes all if no other args specified
  }


}