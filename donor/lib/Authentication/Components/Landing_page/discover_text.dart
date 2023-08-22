import 'package:flutter/material.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';
class Discovery extends StatelessWidget {
  const Discovery({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing(context);
    double screenWidth = sizing.setWidth();

    return Container(
      padding: const EdgeInsets.only(left: 40.0,right: 40.0),
      child: Text(
        "Discover the Joy of Giving",
        style: TextStyle(
          fontSize: screenWidth*0.10,
          fontWeight: FontWeight.w700,
          color: Color(0xffFFFFFF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
