import 'package:flutter/material.dart';
import 'package:muza/Pages/Splash.dart';


void main() {
  runApp(
      Muza());
}
 class Muza extends StatelessWidget {
   const Muza({Key?key});

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: Splash(),
     );
   }
 }
