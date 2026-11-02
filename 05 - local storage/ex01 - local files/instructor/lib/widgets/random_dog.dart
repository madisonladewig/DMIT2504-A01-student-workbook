import 'dart:io'; // i/o -> "input, output". common built-in package of many languages used to interact with OS paths and file i/o
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';  // flutter pub add path_provider

/* 
    Step 1: implementing local file storage (goal: save dog pic to a file)

    We'll be using the `path_provider` plugin (https://pub.dev/packages/path_provider),
    which makes it easier for us to interact with filesystems (and not have to write manual code for each platform).

    Some abstractions it provides:
     - getTemporaryDirectory()             -> lets us create a temp dir for writing temporary files
     - getApplicationDocumentsDirectory()  -> access to a persistent local folder for storage, belonging to this app
     - getApplicationSupportDirectory()    -> internal app files, kept but not meant for user (kind of like AppData folders in Windows)
     - getDownloadsDirectory()             -> guess lol

    The reason the plugin gives us all these fairly specific abstractions is that all of them live/behave very differently
    depending on e.g. Windows, mobile, web, etc. so this just lets us write one high-level abstraction once, which will compile
    down to platform-specific implementation via this plugin/library.

    N.B. - directory retrieval is async, so you'll likely have to use method().then() or compartmentalised helper functions
    in places that can't be async (such as initState).
*/

class RandomDogImage extends StatefulWidget {
  const RandomDogImage({super.key});

  @override
  State<RandomDogImage> createState() => _RandomDogImageState();
}

class _RandomDogImageState extends State<RandomDogImage> {
  String dogImagePath = '';
  int likes = 0;
  int dislikes = 0;

  static Future<String> getRandomDogUrl() async {
    const dogEndpoint = 'https://dog.ceo/api/breeds/image/random';
    var response = await get(Uri.parse(dogEndpoint));
    return await jsonDecode(response.body)['message'];
  }

  Future<File> _dogFile() async {
    // helper method that retrieves the saved dog file for us,
    final dir = await getTemporaryDirectory(); // getTemporaryDirectory() is one of the abstractions provided by the package
    // i.e. "knows where it lives" & returns an instance of that file loaded into memory / as a dart object
    return File('${dir.path}/dog.jpg');
    // we can use this to both read from & write to the file; this is basically just the 'dart<-->filesystem' adapter to it
  }

  // I have to run this *every* single time I change the dog (via changing the dog URL) if I want 
  // every new dog to save to the file.

  // You may notice this means we're *redownloading* the byte data of the dog pic that we *already* downloaded via Image.network(url)
  // to show it in the first place. We don't get access to the bytes data via Image.network so in a simple implementation, we're forced to
  // grab it a second time.
  Future<void> _saveImage(String url) async {
    // download the image, open the dog pic file, dump the bytes from the image into the dog pic file (i.e. saving it)
    final response = await get(Uri.parse(url));  // fetch the image (the "body" of the response is the image bytes)
    final file = await _dogFile();  // open the file
    await file.writeAsBytes(response.bodyBytes);

    // optional console log
    debugPrint('Saved dog to: ${file.path}');
  }

  Future<void> _loadInitialDog() async {
    final file = await _dogFile();

    if (await file.exists()) {
      setState(() { dogImagePath = file.path; });
      // Image.network cannot render from a local path, so we'll have to change the display end too
    } else {
      final url = await getRandomDogUrl();
      setState(() { dogImagePath = file.path; });
      _saveImage(url);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialDog();
  }


  Widget _buildDogImage() {
    Widget childWidget;

    if (dogImagePath != '') {
      // there are 'safer' or more conceptually correct ways to do this, but this is fine at this level
      dogImagePath.startsWith('http')
      ? childWidget = Image.network(dogImagePath)
      : childWidget = Image.file(File(dogImagePath)); // note: pass the instance (file loaded in as bytes) not the path
    } else {
      childWidget = const CircularProgressIndicator();
    }

    return GestureDetector(
      onTap: () {
        getRandomDogUrl().then((url) {
          _setdogImagePath(url, true);
        });
      },
      onLongPress: () {
        getRandomDogUrl().then((url) {
          _setdogImagePath(url, false);
        });
      },
      child: childWidget,
    );
  }

  void _setdogImagePath(String url, bool liked) {
    setState(() {
      dogImagePath = url;
      if (liked) {
        likes += 1;
      } else {
        dislikes += 1;
      }
    });
    _saveImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildDogImage(),
        LikeText(like: true, number: likes),
        LikeText(like: false, number: dislikes),
      ],
    );
  }
}

class LikeText extends StatelessWidget {
  /// true to render "Likes: " and false to render "Dislikes: "
  final bool like;
  final int number;

  const LikeText({this.like = true, this.number = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
      ),
      child: Row(
        children: <Widget>[
          Text(
            like ? "Likes: " : "Dislikes: ",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$number',
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
