import 'package:covid_19_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black.withOpacity(0.05),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19 Tracker',
      theme: ThemeData(
        backgroundColor: Colors.white.withOpacity(0.97),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
