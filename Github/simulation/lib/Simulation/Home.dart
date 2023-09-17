import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:simulation/Simulation/location.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome

class VideoPlayerPage extends StatefulWidget {
  final String videoAssetPath;
  final String videoTextOption;

  VideoPlayerPage({required this.videoAssetPath, required this.videoTextOption});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    // Lock the screen orientation to portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _videoController = VideoPlayerController.network(widget.videoAssetPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void _restartVideo() {
    _videoController.seekTo(Duration.zero); // Seek the video to the beginning
    _videoController.play(); // Play the video
  }

  void _forwardVideo() {
    final newPosition = _videoController.value.position + Duration(seconds: 5);
    _videoController.seekTo(newPosition);
  }

  void _backwardVideo() {
    final newPosition = _videoController.value.position - Duration(seconds: 5);
    _videoController.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    print('Collection Name: ${widget.videoTextOption}');
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("St. Joseph Engineering College")),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _videoController.value.isInitialized
                ? AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            )
                : CircularProgressIndicator(),
          ),
          TextOverlay(
            subtitleStream: FirebaseFirestore.instance.collection(widget.videoTextOption).snapshots(),
            videoController: _videoController,
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_videoController.value.isPlaying) {
                  _videoController.pause();
                } else {
                  _videoController.play();
                }
              });
            },
            child: Icon(
              _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Location(), // Navigate to Location.dart
              ));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on),
                Text('Destination', style: TextStyle(fontSize: 9.0)),
              ],
            ), // Replace with the desired icon
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _restartVideo,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.replay),
                Text('Replay', style: TextStyle(fontSize: 9.0)),
              ],
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _backwardVideo,
            child: Icon(Icons.replay_5), // 5-second backward
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: _forwardVideo,
            child: Icon(Icons.forward_5), // 5-second forward
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();

    // Allow all screen orientations when disposing the widget
    SystemChrome.setPreferredOrientations([]);
  }
}

class TextOverlay extends StatelessWidget {
  final Stream<QuerySnapshot> subtitleStream;
  final VideoPlayerController videoController;

  TextOverlay({required this.subtitleStream, required this.videoController});

  Stream<Duration> createPositionStream(VideoPlayerController controller) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 200)); // Update every 200 milliseconds
      yield await controller.position ?? Duration.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: subtitleStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final docs = snapshot.data!.docs;

        return StreamBuilder<Duration>(
          stream: createPositionStream(videoController),
          builder: (context, positionSnapshot) {
            if (!positionSnapshot.hasData || !videoController.value.isInitialized) {
              return Container();
            }

            final currentSecond = positionSnapshot.data!.inSeconds;

            // Find the text and positioning information based on the current second
            final activeSubtitles = docs.where((doc) {
              final secondFrom = doc['second_from'] as int;
              final secondTo = doc['second_to'] as int;
              return currentSecond >= secondFrom && currentSecond <= secondTo;
            }).toList();

            return Stack(
              children: activeSubtitles.map((doc) {
                print(currentSecond);
                final top = doc['top']?.toDouble() ?? 0.0;
                final left = doc['left']?.toDouble() ?? 0.0;
                final right = doc['right']?.toDouble() ?? 0.0;
                final text = doc['text'].toString();
                print('Top: $top, Left: $left, Right: $right, TextonTop: $text');
                final W = MediaQuery.of(context).size.width;
                final H = MediaQuery.of(context).size.height;

                // Calculate the appropriate positioning using absolute values
                final position = Positioned(
                  top: top * H,
                  left: left * W,
                  right: right * W,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.0),
                    color: Colors.black.withOpacity(0.6),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: W * 0.0325,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );

                return position;
              }).toList(),
            );
          },
        );
      },
    );
  }
}
