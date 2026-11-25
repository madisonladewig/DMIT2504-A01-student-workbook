import 'package:flutter/material.dart';

import 'app_state.dart';


class HomePage extends StatelessWidget {
  const HomePage({required this.authAppState, super.key});

  final ApplicationState authAppState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Demo'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 16.0),
          // the only thing that's different is this ListenableBuilder
          // this is a flutter built-in that: 1) attaches to some entity that fires ChangeNotifier notifications,
          //                                  2) rebuilds that part of the element tree accordingly *without* having to make this a stateful widget
          // if we used a plain `Builder` instead, nothing would update (`Builder` just builds once).
          ListenableBuilder(
            listenable: authAppState,  // subscribe to this listenable instance.
                                       // whenever a notifyListeners() is fired from our application state instance,
            builder: (context, child) {  // this rebuild/re-render will run again
              return authAppState.loggedIn
                  ? ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/profile'),
                      child: const Text('Profile'),
                    )
                  : ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/sign-in'),
                      child: const Text('Sign In'),
                    );
            },
          )
        ],
      ),
    );
  }
}