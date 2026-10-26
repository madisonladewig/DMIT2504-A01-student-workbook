import 'package:flutter/material.dart';


class ReturnedData extends StatelessWidget {

  const ReturnedData({super.key});

  @override build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('This is a page that will return data back to the previous one!'),
          ElevatedButton(
            onPressed: () {
              // to return data back to the previous page/widget, just pass a value to the pop()
              Navigator.of(context).pop("Here is a string I'm returning back to the previous page.");
            },
            child: const Text("go back"),
          ),
        ]
      ),
    );
  }

}