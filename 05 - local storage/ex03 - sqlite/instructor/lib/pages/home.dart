import 'package:flutter/material.dart';
import 'package:week_06_sqlite/models/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Todo> _todos = [];
  int _counter = 0;

  void _addTodo() {
    setState(() {
      _todos.add(Todo(description: 'Todo $_counter', done: false));
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos Application'),
      ),
      body: Center(
        child: Column(
          children: [
            _todos.isEmpty
                ? const Text('No todos')
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _todos[index].description,
                            style: TextStyle(
                                decoration: _todos[index].done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          trailing: Checkbox(
                            value: _todos[index].done,
                            onChanged: (value) {
                              setState(() {
                                _todos[index].done = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
            if (_todos.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _todos.clear();
                    _counter = 0;
                  });
                },
                child: const Text('Delete All'),
              ),
            const SizedBox(height: 96.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
