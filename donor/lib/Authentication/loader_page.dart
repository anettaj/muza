import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing(context);
    // double screenWidth = sizing.setWidth();
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
      body:Container(
        child: Center(
          child: SvgPicture.asset(
            'lib/Authentication/Assets/icon.svg',
              height: screenHeight*0.2,
          ),
        ),
      ),
    );

  }}
