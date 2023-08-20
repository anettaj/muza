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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor : Color(0xFF1D1C2A),
        colorScheme: ColorScheme.light(
          primary:Color(0xFF1b1b26),

        ),
      ),

      home: Landing_page(),
    );
  }
}

