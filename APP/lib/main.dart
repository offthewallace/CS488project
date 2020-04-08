import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'package:tinder_cards/ProfilePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override


   build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder cards demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage()
    );
  }
}
