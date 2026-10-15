import 'package:flutter/material.dart';

// import via package name (uses whatever this project is called in pubspec.yaml)
// import 'package:week_04_gestures/widgets/random_dog.dart';

// relative import, since both main.dart and widgets/* are in lib/
import 'widgets/random_dog.dart';
import 'widgets/page_title.dart';


// I would argue relative imports for files internal to this project would be better,
// because they implicitly communicate that the imports are local / not from a 3rd party pkg.
// I would personally stick to using package: for third-party packages so someone reading my code
// could intuit the difference.

Future<void> main() async {
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
                PageTitle('DO U LIEK TEHSE DOGS?!?!!11'),
                RandomDogImage(),
              ]
            ),
          ),
        ),
      ),
    );

  }
}






