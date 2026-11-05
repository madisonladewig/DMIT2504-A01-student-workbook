import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/*
  Some persistent data (e.g. most user preferences) don't justify the i/o & code overhead
  of opening, closing, reading from, and writing to files.

  Much faster & simpler is the ability to use a cache that persists across app restarts
  which has faster i/o but stores simpler data.

  shared_preferences creates a persistent local cache that can store key:value data.
  e.g. {'darkmode': false, 'language': 'en-CA'}
  - keys are always strings
  - values can be bool, int, double (a.k.a. 'float' in other langs), string, List<String>
  - we get access to the following abstractions:
     a) getters and setters to read/write, e.g. :
      - setBool, getBool   (etc. - all other types except List<String> are the same)
      - setStringList, getStringList
     b) remove(key) to reset a key's value to null
     c) clear()     to reset all cached data
  - initial values for all keys (if never specified/written to) is null

  Our game plan:
  1) install the shared_preferences package
  2) every time we toggle the setting, write the new value to local cache
  3) when we restart the app, read that value from cache and use it

  NOTE: won't work on browser version of app runtime
*/

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _darkMode = false;

  Future<bool> _getDarkModeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkMode') ?? false; // if this bool is null in the cache, automatically use false as a default
  }

  @override
  void initState() {
    super.initState();
    _getDarkModeFromPreferences().then(  // returns that boolean
      (isDarkMode) { setState(() { _darkMode = isDarkMode; }); }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shared Prefs Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDarkModeSwitch(),
              const SizedBox(height: 20),
              Text(_darkMode ? 'Dark Mode is ON' : 'Dark Mode is OFF'),
            ],
          ),
        ),
      ),
    );
  }

  SwitchListTile _buildDarkModeSwitch() {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: _darkMode,
      onChanged: (value) async {
        setState(() {
          _darkMode = value;
        });
        // we want to persist the new value to the cache every time it's changed
        final prefs = await SharedPreferences.getInstance();  // load the shares prefs; uses a singleton pattern
        await prefs.setBool('darkMode', value);  // set (key, val)
      },
    );
  }
}
