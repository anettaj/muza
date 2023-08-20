import 'package:donor/Authentication/landing_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
      Donar());
}
class Donar extends StatelessWidget {
  const Donar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Set the scaffold background to transparent
      ),
      home: LandingPage(),
    );
  }
}

