import 'package:flutter/material.dart';
import 'package:muza/Pages/MusicList.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    Future.delayed(
      Duration(seconds: 2),
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MusicListPage()),
        );
      },
    );

    return Scaffold(
      backgroundColor:Color(0xff0a100F0F),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
         Image.asset('assets/Spla.jpg',
            fit: BoxFit.fill,
            height: h,
            width: w,
          ),

          Text(
            'Muza',
            style: TextStyle(
              fontFamily: 'Zen Dots',
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color
            ),
          ),



        ],
      ),
    );
  }
}
