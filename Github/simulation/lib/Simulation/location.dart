import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulation/Simulation/Home.dart';
import 'package:flutter/services.dart';

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
  String? loadingMessage; // Added variable for loading message
  bool submitted = false; // Added variable to track submission
  final List<String> fromOptions = ['Entrance', 'Administration', 'Church'];
  final List<String> toOptions = ['Administration', 'Student Square', 'Church'];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchVideoAssetPath(String from, String to) async {
    setState(() {
      loadingMessage = 'Matching video path...'; // Display loading message
    });

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
          videoAssetPath = '$retrievedVideoFilename';
          videoTextOption = '$retrievedVideoText';
          loadingMessage = null; // Clear loading message
          print('subtitle:');
          print(videoTextOption);
          print(videoAssetPath);
        });
      } else {
        setState(() {
          videoAssetPath = null;
          loadingMessage = null; // Clear loading message
        });
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      setState(() {
        videoAssetPath = null;
        loadingMessage = null; // Clear loading message
      });
    }
  }

  void exitApp() {
    // Exit the app by popping all routes (clearing the navigation stack)
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void navigateToVideoPlayerScreen() {
    if (videoAssetPath != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(videoAssetPath: videoAssetPath!, videoTextOption: videoTextOption!),
        ),
        // Define a custom condition to allow going back to the 1st previous page only
            (route) => route.isFirst,
      );
    } else {
      // Handle no video found for the selected destinations.
      // You can show an error message to the user.
      setState(() {
        videoAssetPath = null;
        loadingMessage = 'Invalid Selection'; // Display "Invalid Selection" message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // This callback will prevent the back button from working.
      onWillPop: () async {
        // You can add logic here if needed to confirm exit
        // For example, show a dialog to confirm exit
        return true; // Prevent going back
      },
      child: Scaffold(
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
            child: Column(
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
                    setState(() {
                      submitted = true; // Mark as submitted when button is pressed
                    });
                    if (selectedFrom != null && selectedTo != null) {
                      await fetchVideoAssetPath(selectedFrom!, selectedTo!);

                      if (videoAssetPath != null) {
                        navigateToVideoPlayerScreen();
                      } else {
                        // Handle no video found for the selected destinations.
                        // You can show an error message to the user.
                        setState(() {
                          videoAssetPath = null;
                          loadingMessage = 'Invalid Selection'; // Display "Invalid Selection" message
                        });
                      }
                    }
                  },
                  child: Text('Submit'),
                ),

                SizedBox(height: 16.0),

                if (loadingMessage != null && submitted ) // Display loading message if not null
                  Text(
                    loadingMessage!,
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),

                if (videoAssetPath != null&& selectedFrom == null && selectedTo == null)
                  Text(
                    'Got the video',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),


                SizedBox(
                  height: 20.0,
                ),

                Stack(
                  children:[
                  Positioned(
                    child: ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Icon(Icons.exit_to_app),
                    ),
                  ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
