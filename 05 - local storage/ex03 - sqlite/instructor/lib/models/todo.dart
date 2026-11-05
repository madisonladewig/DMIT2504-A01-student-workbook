class Todo {
  int? id; // nullable because if I'm writing a new instance to db, I don't know what the pk/id is yet
  String description;
  bool done;

  Todo({required this.description, required this.done});

  /* two birds one stone here:
      1. sq(f)lite can't do booleans, so we need to remap to 0/1
      2. sq(f)lite expects data as a map, so we need a method to spit out {key: value} data for this instance

      fortunately, both these concerns are satisfied by one thing:
  */
  Map<String, dynamic> toMap() {
    // translate data held in instance attributes to {k: v} map that can be written to sqlite
    return {
      'id': id,
      'description': description,
      'done': done ? 1 : 0  // have to convert boolean to int for sqlite; if done=true => val is 1
    };
  }

}
