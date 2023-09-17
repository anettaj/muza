import 'package:flutter/material.dart';
import 'package:simulation/Simulation/location.dart';// Replace with your import path

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true; // Track the loading state

  @override
  void initState() {
    super.initState();
    // Call a method to initialize the video URL and navigate after a delay
    initializeAndNavigate();
  }

  Future<void> initializeAndNavigate() async {


    // Simulate a delay before navigating to the video player screen
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false; // Loading is done, update the loading state
    });

    // Navigate to the video player screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Location(),
            //VideoPlayerScreen(videoUrl: videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff81CB75),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/sjec-logo.png', height: 100.0, width: 100.0,),
            SizedBox(height: 10),
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
            SizedBox(height: 20), // Add spacing
            isLoading
                ? CircularProgressIndicator() // Display loader while loading
                : SizedBox.shrink(), // Empty space when loading is done
          ],
        ),
      ),
    );
  }
}
