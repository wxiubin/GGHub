import 'package:flutter/material.dart';

class ExploreAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ExploreAdd> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ExploreAdd'),
        ),
        body: Text(''),
      ),
    );
  }
}
