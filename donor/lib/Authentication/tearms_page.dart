import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';
class TearmsPage extends StatelessWidget {
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
          Color(0xFF1F1E2C),
          Color(0xFF030303),
        ],
      ),
      body:Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:55.0,left: 10.0),
                    child: Text('Terms & Conditions',
                    style: TextStyle(
                      color: Color(0xFF4A465D),
                      fontSize: screenHeight*0.080,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
                    child: Text('Use of Share2Care constitutes acceptance of these Terms.',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: screenHeight*0.02,
                      ),),
                  )
                ],
              ),
            ),
    );

  }}
