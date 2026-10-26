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
              // this can stay as-is; again, .pop() doesn't need to care about specifics
              Navigator.of(context).pop();
            },
            child: const Text("go back"),
          ),
        ]
      ),
    );
  }

}