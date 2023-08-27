import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:donor/Authentication/Components/sizing_components.dart';
import 'landing_page.dart'; // Import your LandingPage

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    // Start the timer in the initState method
    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing(context);
    double screenHeight = sizing.setHeight();
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF030303),
          Color(0xFF1F1E2C),
          Color(0xFF030303),
        ],
      ),
      body: Container(
        child: Center(
          child: SvgPicture.asset(
            'lib/Authentication/Assets/icon.svg',
            height: screenHeight * 0.2,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Loader(), // Use your splash screen widget as the initial route
  ));
}
