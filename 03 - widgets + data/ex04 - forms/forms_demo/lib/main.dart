import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile UI Form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'New User Form',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Username'),
                ),
              ),
              const TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  label: Text('Password'),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => false,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


