import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ApplicationState authAppState = ApplicationState();

  runApp(MainApp(authAppState: authAppState));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.authAppState, super.key});

  final ApplicationState authAppState;

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) {
        return HomePage(authAppState: authAppState);
      },
      '/sign-in': (context) {
        // SignInScreen is a fully written out widget from firebase_ui_auth, provides formfields, handling, everything!
        return SignInScreen(
          actions: [
            // whenever auth state changes, both the local and remote layers on firebase get notified
            AuthStateChangeAction((context, state) {
              final user = switch (state) {
                SignedIn state => state.user,   // when we change stateful data in firebase, it updates both locally and on the remote
                UserCreated state => state.credential.user,
                _ => null,
              };

              if (user == null) {
                return;
              }

              if (state is UserCreated) {
                user.updateDisplayName(user.email!.split('@').first);
              }

              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ],
        );
      },
      '/profile': (context) {
        // ProfileScreen is also fully built out for you from firebase_ui_auth
        return ProfileScreen(
          actions: [
            SignedOutAction((context) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            })
          ],
        );
      }
    };

    return MaterialApp(
      title: 'Firebase UI Auth Demo',
      routes: routes,
    );
  }
}