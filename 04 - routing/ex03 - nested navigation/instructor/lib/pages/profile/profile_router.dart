import 'package:flutter/material.dart';

import 'routes.dart';  // gotta import my route mapping
// and every single page we want to route to; this file is where route name <-> widget are bound together
import 'profile_page.dart';
import 'profile_options1.dart';
import 'profile_options2.dart';
import 'profile_options3.dart';


// instead of importing every little route/widget in my top-level router,
// I now have this ProfileRouter() I can pass instead, which will dynamically generate the route
// (and therefore determine what needs to be rendered) whenever profile/ or anything inside profile/ is hit as a route.
class ProfileRouter extends StatefulWidget {

  // let's make it so that we can change the initial page we land on from external routing
  final String initialRoute;

  const ProfileRouter({ super.key, this.initialRoute = profileHomeRoute });

  @override
  State<ProfileRouter> createState() => _ProfileRouterState();

}


class _ProfileRouterState extends State<ProfileRouter> {

  // we need to have a persistent way to reference this navigator across rebuilds
  // when we create our own new stateful things (new navigator, form, etc.) we gotta supply that key
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        // you'll notice the back arrow on any of these pages takes us back to the homepage
        // because the AppBar's automatic back arrow pops the *root* navigator.
        // when we've instantiated the appbar, we haven't made this new internal navigator yet (that happens next).
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // even though I haven't insantiated the internal navigator/router yet, I can still reference it with the state key I gave it
            // everything we're writing here assumes the widgets fully render into the tree. the *code* just needs a way to reference 
            // a navigator that hasn't been built yet - really similar to how we were referencing stuff in form logic
            if (_navigatorKey.currentState!.canPop()) {
              // if the internal router can go back in its own history, do that
              _navigatorKey.currentState!.pop();
            } else {
              // if I have nothing to go back to in this nested router, go back via the global router we got here from
              Navigator.of(context).pop(); // <- this code at this moment point to the global router, because the profile/ Navigator
                                           // doesn't get created until the body: below
            }
          },
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.initialRoute,  // we can reference any widget-level instance variables from the state class via widget.whatever
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {

    Widget page;

    // boilerplate is the same as the main.dart functional router
    switch (settings.name) {
      case profileHomeRoute:
        page = const ProfilePage();
        break;
      case profileOptions1Route:
        page = const ProfileOptions1();
        break;
      case profileOptions2Route:
        page = const ProfileOptions2();
        break;
      case profileOptions3Route:
        page = const ProfileOptions3();
        break;
      default:
        throw Exception('Unknown profile route: ${settings.name}');
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,  // pass settings to next route (contains route name & args)
    );

  }

}