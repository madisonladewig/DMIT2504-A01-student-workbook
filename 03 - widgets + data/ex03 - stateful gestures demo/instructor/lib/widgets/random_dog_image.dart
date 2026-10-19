import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

import './display_likes.dart'; // you don't need to ./ but can if you want


class RandomDogImage extends StatefulWidget {

  const RandomDogImage({super.key});

  // so we pack all our stuff inside a mutable comparment
  @override
  State<RandomDogImage> createState() => _RandomDogImageState();
}


class _RandomDogImageState extends State<RandomDogImage> {

  String dogImageUrl = '';
  int    likes       = 0;
  int    dislikes    = 0;

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response      = await get(Uri.parse(dogEndpoint));

    return jsonDecode(response.body)['message'];
  }

  Future<void> fetchNewDog() async {
    if (!mounted) return;

    setState(() { dogImageUrl = ''; });
    final url = await getRandomDogUrl();

    setState(() { dogImageUrl = url; });
  }

  Future<void> _getNextDog() async {
    final url = await getRandomDogUrl();
    if (!mounted) return; // if component isn't (re-)rendered back into the element tree, gtfo
    setState(() { dogImageUrl = url; });
  }

  Widget _buildDogImage() {
    return GestureDetector(
      // depending on the device, you may still see counts incrementing in multiples before seeing a new image;
      // there may be a tiny, imperceptible delay between element reloading into tree & browser/client/device actually rendering image
      // onTap: () {
      //   setState(() => likes += 1); // I can use () => value; instead of () { logic }; in a callback if I'm just returning a new value
      //   _getNextDog();
      // },
      // onDoubleTap: () {
      //   // "super-like" - when I add a double tap, single-tap events process a little slower, because flutter is waiting to see if it becomes a doubletap
      //   // this is only relevant in a case where you WANT to allow taps to happen as fast as possible
      //   setState(() => likes += 2);
      //   _getNextDog();
      // },
      // onLongPress: () {
      //   setState(() => dislikes += 1); // I can use () => value; instead of () { logic }; in a callback if I'm just returning a new value
      //   _getNextDog();
      // },
      onHorizontalDragEnd: (details) { // unlike a click, where we don't care about event details, we do for drags
        final velocity = details.primaryVelocity ?? 0; // primaryVelocity is nullable, so I want it to be zero if so
        if (velocity > 0) { // positivelocity: rightwards drag
          setState(() => likes += 1);
          print("swiped right");
        } else if (velocity < 0) { // negative velocity: leftwards drag
          setState(() => dislikes += 1);
          print("swiped left");
        }
        _getNextDog();
      },
      child: SizedBox(
        height: 300,
        child: dogImageUrl.isEmpty 
          ? const Text("Loading dog...")
          : Image.network(dogImageUrl)
      ),
    );
  }


  @override
  void initState() {
    super.initState(); 
    fetchNewDog();
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[   
        _buildDogImage(),
        const SizedBox(height: 24),
        const Text("press dog to get new dog"),
        DisplayLikes(numLikes: likes),
        DisplayLikes(numLikes: dislikes, forDislikes: true),
      ]
    );
  }
}