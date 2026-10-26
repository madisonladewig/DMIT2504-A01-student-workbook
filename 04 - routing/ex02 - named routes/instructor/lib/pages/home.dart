import 'package:flutter/material.dart';

// no more gross tight coupling


class Home extends StatelessWidget {

  const Home({super.key});

  @override build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('This is the homepage; if you don\'t like it, leave!'),
          ElevatedButton(
            onPressed: () {
              /* 
              routing looks like it's about transporting the user from A to B,
              but more accurately, it's about pushing things onto and popping things off of a *stack*.

              the idea here is, whatever the topmost 'route' (i.e. widget) is on the stack currently
              is what gets rendered out to the screen.
              
              parts of this expression:
                  Navigator    - the app-wide instance that handles routing (built-in)
                  of.context() - navigator/router, like theme, is passed down the element tree through context
                  push()       - add a route to the top of the stack (will render the new widget on top of route stack)
                  the rest     - boilerplate (have to return a type-specific routed instance that itself returns a widget)
              */
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  print("replace me with better routing!");
                }));

            },
            child: const Text("go to other page"),
          ),
        ]
      ),
    );
  }

}