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

  Future<void> getTodos() async {}

  Future<void> addTodo(Todo todo) async {}

  Future<void> updateTodo(Todo todo) async {}

  Future<void> deleteAllTodos() async {}


}