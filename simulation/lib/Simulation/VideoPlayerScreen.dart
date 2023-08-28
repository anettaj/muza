import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/simu.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      final currentTime = _controller.value.position;
      if (currentTime >= Duration(seconds: 10) &&
          currentTime <= Duration(seconds: 15)) {
        setState(() {
          _showText = true;
        });
      } else {
        setState(() {
          _showText = false;
        });
      }
    });
  }

  void _restartVideo() {
    _controller.seekTo(Duration.zero); // Reset video to the beginning
    _controller.play(); // Start playing after reset
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player with Text Overlay')),
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            if (_showText)
              Positioned(
                top: 20,
                child: Center(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Text Overlay',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
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

void main() {
  runApp(MaterialApp(home: VideoPlayerScreen()));
}
