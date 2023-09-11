import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulation/Simulation/Home.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String? selectedFrom;
  String? selectedTo;
  String? videoAssetPath;
  String? videoTextOption;

  final List<String> fromOptions = ['Entrance', 'Administration', 'Church'];
  final List<String> toOptions = ['Administration', 'Student Square', 'Church'];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchVideoAssetPath(String from, String to) async {
    try {
      final querySnapshot = await _firestore
          .collection('videos')
          .where('from', isEqualTo: from)
          .where('to', isEqualTo: to)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        final retrievedVideoFilename = data['videoName'] as String;
        final retrievedVideoText = data['subtitle'] as String;
        setState(() {
          videoAssetPath = 'assets/video/$retrievedVideoFilename';
          videoTextOption = '$retrievedVideoText';
          print('subtitle:');
          print(videoTextOption);
          print(videoAssetPath);
        });
      } else {
        setState(() {
          videoAssetPath = null;
        });
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      setState(() {
        videoAssetPath = null;
      });
    }
  }

  void navigateToVideoPlayerScreen() {
    if (videoAssetPath != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(videoAssetPath: videoAssetPath!,videoTextOption: videoTextOption!),

        ),
      );
    } else {
      // Handle no video found for the selected destinations.
      // You can show an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("St. Joseph Engineering College"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1.jpeg'), // Replace with your image asset path
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // "From" Dropdown with Background Image and Opacity
              Stack(
                children: [
                  Opacity(
                    opacity: 0.7, // Adjust the opacity level as needed
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'From',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: selectedFrom,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFrom = newValue;
                        });
                      },
                      items: fromOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // "To" Dropdown with Background Image and Opacity
              Stack(
                children: [
                  Opacity(
                    opacity: 0.7, // Adjust the opacity level as needed
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'To',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: selectedTo,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTo = newValue;
                        });
                      },
                      items: toOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () async {
                  if (selectedFrom != null && selectedTo != null) {
                    await fetchVideoAssetPath(selectedFrom!, selectedTo!);

                    if (videoAssetPath != null) {
                      navigateToVideoPlayerScreen();
                    } else {
                      // Handle no video found for the selected destinations.
                      // You can show an error message to the user.
                    }
                  }
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 16.0),
              if (videoAssetPath != null)
                Text(
                  'Video Asset Path: $videoAssetPath',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyan,
                  ),
                ),
              if (videoAssetPath == null)
                Text(
                  'No video found for the selected destinations.',
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),

    );
  }
}
