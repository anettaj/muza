import 'package:flutter/material.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';
class Quotes extends StatelessWidget {
  const Quotes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing(context);
    double screenWidth = sizing.setWidth();
    double screenHeight = sizing.setHeight();

    return Container(
      padding: EdgeInsets.only(top: screenHeight*0.06, left: 58.0, right: 58.0),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: 'The meaning of life is to find your gift. The purpose of life is to ',
          style: TextStyle(
            fontSize: screenWidth*0.06,
            fontWeight: FontWeight.w400,
            color: Color(0xffFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'give it away.',
              style: TextStyle(
                fontSize: screenWidth*0.05,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFFFFF),
                backgroundColor: Color(0xff37A22E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
