import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _videoPlayerController,
      _videoPlayerController2,
      _videoPlayerController3;

  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings();

  final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
  CustomVideoPlayerWebSettings(
    src: longVideo,
  );

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      longVideo,
    )..initialize().then((value) => setState(() {}));
    _videoPlayerController2 = VideoPlayerController.network(video240);
    _videoPlayerController3 = VideoPlayerController.network(video480);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        "240p": _videoPlayerController2,
        "480p": _videoPlayerController3,
        "720p": _videoPlayerController,
      },
    );

    _customVideoPlayerWebController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: _customVideoPlayerWebSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Appinio Video Player"),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            kIsWeb
                ? Expanded(
              child: CustomVideoPlayerWeb(
                customVideoPlayerWebController:
                _customVideoPlayerWebController,
              ),
            )
                : CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),
            CupertinoButton(
              child: const Text("Play Fullscreen"),
              onPressed: () {
                if (kIsWeb) {
                  _customVideoPlayerWebController.setFullscreen(true);
                  _customVideoPlayerWebController.play();
                } else {
                  _customVideoPlayerController.setFullscreen(true);
                  _customVideoPlayerController.videoPlayerController.play();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
