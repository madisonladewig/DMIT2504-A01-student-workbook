import 'package:flutter/material.dart';


class OtherPage extends StatelessWidget {

  const OtherPage({super.key});

  @override build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('This is another page!'),
          ElevatedButton(
            onPressed: () {
              // going back is easy! we just pop() without needing specifics
              // -> if we want to go back, we just have to wipe the current route off the top of the stack
              Navigator.of(context).pop();
            },
            child: const Text("go back"),
          ),
        ]
      ),
    );
  }

}