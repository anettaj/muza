import 'dart:io';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:muza/Pages/SongModel.dart'; // Use your local SongModel class
import 'package:muza/Pages/MusicPlayerPage.dart';


class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  List<File> musicFiles = [];

  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Indicate if the application has permission to the library.
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    // (Optional) Set logging level. By default, it will be set to 'WARN'.
    //
    // Log will appear on:
    //  * XCode: Debug Console
    //  * VsCode: Debug Console
    //  * Android Studio: Debug and Logcat Console
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only update the UI if the application has all required permissions.
    if (_hasPermission) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            : FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.hasError) {
              return Text(item.error.toString());
            }

            if (item.data == null) {
              return const CircularProgressIndicator();
            }

            if (item.data!.isEmpty) return const Text("Nothing found!");

            return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context, index) {
                final song = item.data![index];

                return ListTile(
                  title: Text(song.title),
                  subtitle: Text(song.artist ?? "No Artist"),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerPage(song: song),
                      ),
                    );
                  },
                  leading: QueryArtworkWidget(
                    controller: _audioQuery,
                    id: song.id,
                    type: ArtworkType.AUDIO,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
