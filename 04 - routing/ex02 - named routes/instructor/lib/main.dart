import 'package:flutter/material.dart';

/* Our goal: decouple the components/widgets!

  Instead of forcing components to be directly aware of one another,
  we can centralise responsibility for routing information to a separate layer
  (i.e. wiring the routing here, and storing the route mapping in a dedicated place.)
*/

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Placeholder(),
    );
  }
}
