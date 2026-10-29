import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            const Text('Settings Page'),

            ElevatedButton(
              onPressed: () => {print("send me to page 1")},
              child: const Text('page 1'),
            ),

            ElevatedButton(
              onPressed: () => {print("send me to page 2")},
              child: const Text('page 2'),
            ),

            ElevatedButton(
              onPressed: () => {print("send me to page 3")},
              child: const Text('page 3'),
            ),

          ],
        ),
      ),
    );
  }
}

