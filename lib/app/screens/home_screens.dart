import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/app/widget/annotation_recover_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AnnotationRecover display = AnnotationRecover();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minhas Anotações',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: display,
    );
  }
}
