import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  String _displayText = ''; // Holds the text to be displayed

  // Fetched text data (Example)
  Map<int, String> textData = {
    2: 'Welcome to SJEC',
    10: 'walk right ahead',
    20: 'This is the administrative building',
    // Add more data as needed
  };

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      final currentTime = _controller.value.position.inSeconds;

      // Get text based on the current time
      _displayText = textData[currentTime] ?? '';

      setState(() {});
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
        title: Text("St.Joseph engineering college"),
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
            if (_displayText.isNotEmpty)
              Positioned(
                top: 20,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _displayText, // Display the fetched text
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
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
            onPressed: _restartVideo,
            child: Icon(Icons.replay),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
