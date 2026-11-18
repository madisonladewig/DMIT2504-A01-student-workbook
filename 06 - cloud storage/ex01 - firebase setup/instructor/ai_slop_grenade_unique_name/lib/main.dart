import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // make sure our widget/flutter-internal stuff is initialised first

  // then initialise firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // thennnnnn spin up the app instance
  // TLDR: we want firebase to be set up & running before the app runs, otherwise desync/crashing
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("hello, this is just a skeleton app for setting up firebase");
  }

}