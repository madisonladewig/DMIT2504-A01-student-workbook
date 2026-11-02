import 'package:flutter/material.dart';
import 'package:week_06_local_file/widgets/page_title.dart';
import 'package:week_06_local_file/widgets/random_dog.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 24.0),
          child: Center(
            child: Column(
              children: <Widget>[
                PageTitle("Do you like these dogs?"),
                RandomDogImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
