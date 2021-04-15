import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/app/screens/home_screens.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.white,
          backgroundColor: Colors.purple,
        ),
      ),
    );
