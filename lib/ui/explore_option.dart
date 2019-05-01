import 'package:flutter/material.dart';

class ExploreSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ExploreSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ExploreSettingsPage'),
        ),
        body: Text(''),
      ),
    );
  }
}
