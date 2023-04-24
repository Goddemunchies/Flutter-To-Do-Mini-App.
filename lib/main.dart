import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors
            .transparent)); //To remove the overlay of the Phone or Chrome.
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false, //To Remove the Debug Banner.
      title: 'ToDo App',
      home: Home(),
    );
  }
}
