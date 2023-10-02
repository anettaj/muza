import 'dart:io';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:muza/Pages/SongModel.dart'as LocalSongModel;
class SongModel {
  final String title;
  final String artist;
  final String filePath;

  SongModel({
    required this.title,
    required this.artist,
    required this.filePath,
  });
}


class MusicPlayerPage extends StatelessWidget {
  final SongModel song;
  final AudioPlayer audioPlayer = AudioPlayer();

  MusicPlayerPage({required this.song});

  void playMusic() async {
    Uri uri = Uri.file(song.filePath);
    int result = await audioPlayer.play(uri.toString());
    if (result == 1) {
      // Successful playback
      print('Song is now playing');
    } else {
      // Failed to start playback
      print('Error starting playback');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Now Playing: ${song.title}'),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                playMusic(); // Replace 'song.filePath' with actual file path
              },
            ),
            // Add other music player controls here as needed.
          ],
        ),
      ),
    );
  }
}
