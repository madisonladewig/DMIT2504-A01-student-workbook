
import 'package:flutter/material.dart';

import 'widgets/page_title.dart';
import 'widgets/random_dog_image.dart';
// relative import. I'm in lib/, so the direct relative path is ./widgets/blahblah.dart

// the other option is an explicit import, requiring you to state the project/pkg name (see pubspec.yaml):
// import 'package:week_03_network_image/widgets/random_dog_image.dart';

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
        body: Center(
          child: Column(
            children: <Widget>[
              PageTitle('DO U LIEK TEHSE DOGS?!??!11'),
              RandomDogImage(),
            ]
          ),    
        ),
      ),
    );
  }
}



