import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1E1D2B),
          Color(0xFF08080B),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            flex: 5,
            child: Center(
              child: SvgPicture.asset(
                'lib/Authentication/Assets/icon.svg',
                // height: 97.57,
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
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top:30.0,left: 65.0,right: 65.0),

                    child:RichText(
                      textAlign:TextAlign.justify,
                      text: TextSpan(
                        text: 'The meaning of life is to find your gift. The purpose of life is to ',
                        style:TextStyle(
                          fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFFFFF),

                        ),

                        children: <TextSpan>[
                          TextSpan(
                              text: 'give it away.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFFFFFF),
                                backgroundColor:Color(0xff37A22E),
                              ),
                                ),

                        ],
                      ),
                    )
                ),
                Positioned(
                  top: 119.0,
                  right: 50.0,
                  child: Text(
                    "-Pablo Picasso",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  top: 110.0,
                  right: 20.0,
                  child: Image(
                    image: AssetImage('lib/Authentication/Assets/coma_bottom.png'),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: Stack(
              alignment: AlignmentDirectional.center,
              fit: StackFit.passthrough,
              children:[
                Container(
                padding: EdgeInsets.only(top:5.0,left: 40.0,right: 40.0),
                child: Text(
                  "Discover the Joy of Giving",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
                Positioned(
                  top: 80.0,
                  child: Text(
                    "Join a Community that's Transforming Lives",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4a465d),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

             ],
            ),
          ),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor:Color(0xff37A22E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
            ),
            child: Text('Start Donating'),
          ),
           SizedBox(
             height: 50.0,
           ),

           Expanded(
             flex: 1,
             child: Text(
               "© Shere2Care. All rights reserved.",
               style: const TextStyle(
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
