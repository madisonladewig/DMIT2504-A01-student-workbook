import 'package:flutter/material.dart';

/* Our goal: decouple the components/widgets!

  Instead of forcing components to be directly aware of one another,
  we can centralise responsibility for routing information to a separate layer
  (i.e. wiring the routing here, and storing the route mapping in a dedicated place.)
*/
import 'pages/home.dart';
import 'pages/other_page.dart';
import 'pages/returned_data.dart';
// importing everything into main is not the greatest (again, imagine if we had 999 pages)
// but, it's a start for centralising our routing

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* Looking at what MaterialApp can take as inputs, I can pass it a routes table/map:
          
          Map<String, Widget Function(BuildContext)> routes = const <String, WidgetBuilder>{},
        
        ^ this is a lot of barf, so let's see what's going on:
          1) Map<x, y>  ::: a key-value datatype {x: y} (JS: object, python: dictionary, others: map/hashmap)
          2) routes = <String, WidgetBuilder>{} ::: specifically, a map of {'someString' => SomeReturnedWidget()}
      */
      routes: {
        // think of these as 'pseudo-URL routes'; this is more so using a familiar patter (URL routing)
        // to solve a mapping problem (decoupled identifiers for what should be rendered).
        // -> because of the tradition of coming from webapps, it makes more sense to use that scheme for strings than invent some new one
        '/':              (context) => const Home(),
        '/other-page':    (context) => const OtherPage(),
        '/returned-data': (context) => const ReturnedData(),
        // n.b. '/' in most pathing expression (file systems, URLs, etc.) means the directory root
        // -> if you omit a leading slash, it's a relative path, meaning that route will be appended to wherever you are now.
        //    (e.g. if I'm in /users/, and I route to 'some-path' instead of '/some-path/', it will look for '/users/some-path')
      },
    );
  }
}
