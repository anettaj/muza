import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:donor/Authentication/Components/Landing_page/qoute.dart';
import 'package:donor/Authentication/Components/Landing_page/discover_text.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';
import 'package:donor/Authentication/tearms_page.dart';
class LandingPage extends StatelessWidget {
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
      body: Column(
        children: [

          Expanded(
            flex: 5,
            child: Center(
              child: SvgPicture.asset(
                'lib/Authentication/Assets/icon.svg',

              ),
            ),
          ),

           Expanded(
            flex: 6,
            child: Stack(

              fit: StackFit.passthrough,
              children: [
                Positioned(
                  left: 20.0,

                  child: Image(
                    image: AssetImage('lib/Authentication/Assets/coma_top.png'),
                    height: screenHeight*0.1,
                  ),
                ),

                Quotes(),
                Positioned(
                  top: screenHeight*0.19,
                  right: 50.0,
                  child: Text(
                    "-Pablo Picasso",
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight*0.18,
                  right: 20.0,
                  child: Image(
                    image: AssetImage('lib/Authentication/Assets/coma_bottom.png'),
                    height: screenHeight*0.1,
                  ),
                ),
              ],
            ),
          ),

          Discovery(),
          Text(
            "Join a Community that's Transforming Lives",
              style: TextStyle(
              fontFamily: "Lato",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff4a465d),
            ),
            textAlign: TextAlign.center,
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TearmsPage()), // Replace TearmsPage() with the actual name of your terms page
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:const Color(0xff37A22E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
            ),
            child: const Text('Start Donating'),
          ),
            SizedBox(
             height:screenHeight *0.10,
           ),

           const Expanded(
             flex: 1,
             child: Text(
               "© Shere2Care. All rights reserved.",
               style: TextStyle(
               fontFamily: "Lato",
               fontSize: 12,
               fontWeight: FontWeight.w300,
               color: Color(0xff4a465d),
               height: 14/12,
               ),
               textAlign: TextAlign.center,
                ),
           ),
        ],
      ),
    );
  }
}
