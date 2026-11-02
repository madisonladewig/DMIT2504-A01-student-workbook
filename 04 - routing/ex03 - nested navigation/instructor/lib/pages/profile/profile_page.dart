import 'package:flutter/material.dart';

import 'routes.dart';


class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            const Text('Settings Page'),

            // when we get a Navigator.of(context), it finds the *first* Navigator instance upwards in the element tree
            // so, if we had a router/Navigator specific to profile/ section, that is what would be selected here rather than
            // (provided it exists, which we're about to make happen) rather than the top-level router in main.dart
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(profileOptions1Route),
              child: const Text('page 1'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(profileOptions2Route),
              child: const Text('page 2'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(profileOptions1Route),
              child: const Text('page 3'),
            ),

          ],
        ),
      ),
    );
  }
}

