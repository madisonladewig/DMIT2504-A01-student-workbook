import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

///TODO: create a stateful widget, override initState to fetch the initial
/// dog url. NOTE: will need to ensure a callback is used to be certain the
/// widget has been mounted before calling setState().

//We're hitting the URL and getting back:
//{
//  "message"; "url_string_here",
//  "status": "success"
//}

//In Flutter:
//r - hot reload, will not refire main() method
//R - hot restart

//I can't have a stateless widget with an async build method, so we will get it up before showing it:
String dogImageUrl = "";

Future<void> main() async {
  //Need to call the class and then the method within the class:
  dogImageUrl = await RandomDogImage.getRandomDogUrl();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Cute dog
  //"https://images.dog.ceo/breeds/tervuren/yoda_in_car.jpg"

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.network(dogImageUrl),
        ),
      ),
    );
  }
}

class RandomDogImage extends StatelessWidget {
  const RandomDogImage({super.key});

  //static method bc no inputs that change/nothing that is instance dependent
  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = "https://dog.ceo/api/breeds/image/random";

    var response = await get(Uri.parse(dogEndpoint));

    return jsonDecode(response.body)['message'];
  }

  //This is the build method - but we are depending on an API, which is async.
  //Build method HAS to be sync.
  @override
  Widget build(BuildContext context) {
    //A real thing in Flutter! Useful for WIP stuff w/o compiler being mad
    //return const Placeholder();
    return Image.network(dogImageUrl);
  }
}

/*
String dogImageUrl = '';

Future<void> main() async {
  dogImageUrl = await RandomDogImage.getRandomDogUrl();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: RandomDogImage(),
        ),
      ),
    );
  }
}

class RandomDogImage extends StatelessWidget {
  const RandomDogImage({super.key});

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response = await get(Uri.parse(dogEndpoint));
    return await jsonDecode(response.body)['message'];
  }

  @override
  build(BuildContext context) {
    return Image.network(dogImageUrl);
  }
}
*/
