import 'package:flutter/material.dart';


class ReturnedData extends StatelessWidget {

  const ReturnedData({super.key});

  // instead of copy-pasting a million buttons where the only thing changing is the string value,
  // I'm just going to put all the string values in an array and write a loop to generate buttons for them
  
  static const excuses = [
    'lowkey I kinda hate this class',
    'snow',
    'my cat walked (and peed) all over my keyboard and now my computer is fried',
    'i thought it was tomorrow',
    'i thought it was yesterday',
    'i have better things to do (valid)'
  ];

  @override build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          
          const Text('Please select your excuse. The wrong one will be punishable by more snow.'),
          
          for (final excuse in excuses)
            ListTile(
              onTap: () {
                // to return data back to the previous page/widget, just pass a value to the pop()
                Navigator.of(context).pop(excuse);
              },
              title: Text(excuse),
            ),
        ]
      ),
    );
  }

}