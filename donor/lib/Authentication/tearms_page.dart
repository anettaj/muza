import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:donor/Authentication/Components/sizing_components.dart';

class TearmsPage extends StatelessWidget {
  final List<String> str = [
    "Use Share2Care for lawful and responsible purposes at all times.",
    "Do not engage in activities that compromise the security, functionality, or integrity of the platform.",
    "When listing items for donation, provide accurate and truthful information about the items.",
    "Communicate openly and honestly with other users regarding donations and transactions.",
    "The collection, use, and protection of your data are subject to the terms outlined in our Privacy Policy.",
    "Share2Care is not liable for any direct, indirect, incidental, or consequential damages that may arise from your use of the platform.",
    "Accounts found to be in violation of these Terms and Conditions may be suspended or terminated at our discretion.",
    "We reserve the right to update, modify, or amend these Terms and Conditions as needed, with notifications of significant changes.",
    "If you have any questions or concerns regarding these Terms and Conditions, please contact us at support@share2care.in.",
  ];

  @override
  Widget build(BuildContext context) {
    Sizing sizing = Sizing(context);
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
      body: Container(
        margin: EdgeInsets.only(left: 10.0,right: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55.0, left: 10.0),
              child: Text(
                'Terms & Conditions',
                style: TextStyle(
                  color: Color(0xFF4A465D),
                  fontSize: screenHeight * 0.080,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0,bottom: 15.0),
              child: Text('Use of Share2Care constitutes acceptance of these Terms.',
                style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: screenHeight*0.016,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0,right: 20.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: str
                    .map((bulletPoint) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "• ",
                        style: TextStyle(
                          color: Color(0xFF4A465D),
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          bulletPoint,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: screenHeight * 0.012,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
