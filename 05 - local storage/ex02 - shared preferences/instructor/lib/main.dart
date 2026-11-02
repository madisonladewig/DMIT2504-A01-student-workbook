import 'package:flutter/material.dart';

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
      onChanged: (value) {
        setState(() {
          _darkMode = value;
        });
      },
    );
  }
}
