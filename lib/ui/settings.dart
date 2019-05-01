import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Text(''),
      ),
    );
  }
}
