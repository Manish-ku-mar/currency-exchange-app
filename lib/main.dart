import 'package:exhange_rates_flutter/view/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Open Exchange App',
        theme: ThemeData(
          primaryColor: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
