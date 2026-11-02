import 'package:flutter/material.dart';

import '../routes.dart';


class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("homepage")),
      body: const Center(child: Text('here is a homepage if you even care')),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.of(context).pushNamed(profileRoute); },
        child: const Icon(Icons.outdoor_grill),
      ),
    );
  }
}