import 'package:flutter/material.dart';
import 'VideoPlayerScreen.dart'; // Import the VideoPlayerScreen file

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the video player screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(
            videoUrl: 'https://firebasestorage.googleapis.com/v0/b/simulation-4ef2f.appspot.com/o/simu.mp4?alt=media&token=69ca2f61-f3e1-4099-af2f-98cec6360671', // Replace with the actual video URL
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff81CB75),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/sjec-logo.png',height: 50.0,),
            SizedBox(height: 20),
            Text(
              "ST JOSEPH ENGINEERING COLLEGE\nVamanjoor, Mangaluru\nAn Autonomous Institution",
              style: const TextStyle(
                fontFamily: "Inria Serif",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xffFFFDFD),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
