import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// ^ both these libraries ship classes called EmailAuthProvider, which is objectively HORRIBLE
// libary design especially for two libraries that are meant to be used together.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


// TLDR: we have written this class as something that is meant to hold app-wide info (like global prefs, things that need to be init'd before app runs, etc.)
//       this lets me centralise any initialisation/config behaviour for the app instead of polluting top-level UI widgets with that logic/state
class ApplicationState extends ChangeNotifier {

  // ChangeNotifier is a flutter built-in that allows us to automate subscribing to 'events' (ish)
  // and firing notifications to all relevant widgets, controllers, actors, etc. about a change.

  // It's a really similar patter nto JS event listeners, push notifications on your phone, etc.
  // imagine, Instagram for example: following someone new means 'subscribing' to their post events;
  // when they post a new post/story, 'news' of that happening gets pushed to every 'subscriber' (that's how you
  // get push notifications, how stuff shows up on your feed, etc.)

  // the thing that blasts out events doesn't have to know about which entities are listening for that event.
  // if you want to learn more about pub-sub: https://medium.com/@me4saurabh4u/publish-subscribe-pub-sub-model-in-depth-3481d973e6ba

  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    // make sure firebase connectivity/config is initialised first
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    
    // initialise firebase auth & the widgets that ship with that library, just with our email provider
    // if we had more forms of auth we accepted, those would be included too
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    // this can listen for some change for a given user in the auth backend and react accordingly;
    // any time the user signs in or out, we record that and blast an event about it


    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}