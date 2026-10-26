import 'package:flutter/material.dart';

// no more gross tight coupling


class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}


class _HomeState extends State<Home> {

  late String data = '';

  @override build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          
          const Text('This is the homepage; if you don\'t like it, leave!'),
          
          ElevatedButton(
            onPressed: () {
              // push()      -> requires returned widget wrapped inside MaterialPageRoute
              // pushNamed() -> requires string corresponding to mapped route
              Navigator.of(context).pushNamed('/other-page');

            },
            child: const Text("go to other page"),
          ),

          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: () async {
              // the widget I'm routing to pops a string back, so that's the type of its returned value
              String returnedData = await Navigator.of(context).pushNamed('/returned-data') as String;
              setState(() {
                data = returnedData;
              });
            },
            child: const Text("go to page and back to see returned data"),
          ),

          data.isEmpty ? const Text('No data received yet.') : Text('Data received:\n$data') 

        ]
      ),
    );
  }

}