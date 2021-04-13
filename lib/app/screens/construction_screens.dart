import 'package:flutter/material.dart';

class ConstructionScreen extends StatelessWidget {
  final String title;
  const ConstructionScreen({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('Em Construção...'),
        ),
      ),
    );
  }
}
