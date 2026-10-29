import 'package:flutter/material.dart';

import 'routes.dart';
import 'pages/home.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // settings is like context, but for routing info only.
        // it carries settings.name (the name of the route) and settings.arguments (args we can pass to the router)
        Widget page;

        // match to routes we have & (optionally) fire any other behaviour for that route
        switch (settings.name) {
          case homeRoute:
            page = const HomePage();
            // this is a lot of boilerplate for simple routing, but e.g. being inside a function
            // lets me fire other behaviour I might want to (e.g. prefetching data?) for a specific route
            break;
            /* What I want to end up with is the top-level router knowing *only* about the profile section as one route,
               *not* every single subpage in it.

               The profile subsection of the app (and all its pages) will handle its own routing within that set of pages.
              e.g. :
          case profileRoute:
            page: const ProfilePage();  // NOT every single page/route in profile submodule of the app
            break;          
            */
          default:
            throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) => page,
          settings: settings, // pass down route info to the next thing (route name + route args) 
        );

      },
    );
  }
}
