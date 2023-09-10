
import 'package:flutter/material.dart';
import 'package:simulation/Simulation/location.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:simulation/Simulation/location.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoAssetPath;

  VideoPlayerScreen({required this.videoAssetPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  List<Positioned> textPositions = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  Timer? subcollectionTimer;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() async {
      final currentTime = _controller.value.position.inSeconds.toString();
      print('Current Video Time: $currentTime');

      try {
        final docSnapshot = await db.collection('textData').doc(currentTime).get();

        if (docSnapshot.exists) {
          List<Positioned> combinedTextPositions = [];

          // Iterate through subcollections
          for (int i = 1; true; i++) {
            final subcollectionName = 'subcollection$i';

            final subcollectionSnapshot =
            await db.collection('textData').doc(currentTime).collection(subcollectionName).doc('data').get();

            if (subcollectionSnapshot.exists) {
              final subcollectionData = subcollectionSnapshot.data() as Map<String, dynamic>;

              final subEntranceText = subcollectionData['text'] as String;
              final subTopValue = (subcollectionData['top'] as num?)?.toDouble() ?? 0.0;
              final subLeftValue = (subcollectionData['left'] as num?)?.toDouble() ?? 0.0;
              final subRightValue = (subcollectionData['right'] as num?)?.toDouble() ?? 0.0;
              print(
                  'subEntranceText: $subEntranceText, Top: $subTopValue, Left: $subLeftValue, Right: $subRightValue, time:$currentTime');

              final subTextPosition = Positioned(
                top: subTopValue,
                left: subLeftValue,
                right: subRightValue,
                child: subEntranceText.isNotEmpty
                    ? Container(
                  width: 100, // Set an appropriate width
                  height: 30, // Set an appropriate height
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      subEntranceText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
                    : SizedBox.shrink(),
              );

              combinedTextPositions.add(subTextPosition);
            } else {
              break; // No more subcollections to retrieve
            }
          }

          setState(() {
            textPositions = combinedTextPositions; // Set the combined text positions
          });

          // Cancel the previous timer when new data is received
          subcollectionTimer?.cancel();

          // Start a new timer to clear the textPositions after 5 seconds
          subcollectionTimer = Timer(Duration(seconds: 5), () {
            setState(() {
              textPositions = [];
            });
          });
        } else {
          setState(() {
            textPositions = []; // Clear the text positions when there's no data
          });
        }
      } catch (e) {
        print("Error initializing VideoPlayerController: $e");
      }
    });
  }

  void _restartVideo() {
    _controller.seekTo(Duration.zero);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("St. Joseph Engineering College"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: VideoPlayer(_controller),
            ),
            ...textPositions,
          ],
        )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              // Add the action for rewinding by 5 seconds here
              final newPosition = _controller.value.position - Duration(seconds: 5);
              _controller.seekTo(newPosition);
            },
            child: Icon(Icons.replay_5), // Use the appropriate icon
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _restartVideo,
            child: Icon(Icons.replay),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Location(), // Navigate to Location.dart
              )); // Add the action for the new button here
            },
            child: Icon(Icons.location_on), // Replace with the desired icon
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Firebase.app().delete();
    _controller.dispose();
    subcollectionTimer?.cancel(); // Cancel the timer when disposing the screen
  }
}