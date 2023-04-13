import 'dart:ui';
//import 'package:dupe/pages/NavDrawerr.dart';
import 'package:dupe/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data structures and algorithms',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Data Structure and Algorithms'),
      ),
      body: Padding(
       padding: const EdgeInsets.all(30),


         child: RichText(
          text: const TextSpan(
              children: [
              TextSpan(
              text: 'Data structures \n\n',
              style:
              TextStyle(
              color: Colors.black,
              fontSize: 30 ,
              fontWeight: FontWeight.bold,)),

    TextSpan(
    text: 'Definition\n',
    style:
     TextStyle(
      color: Colors.black,
      fontSize: 25 ,
      fontWeight: FontWeight.bold,)),

    TextSpan(
    text: 'The data structure name indicates itself it is a way in which data is used for storing and organising.'
        'It is a way in which data is stored and organised in a computer which can be accessed and modified in a efficiently.'
        'A data structure can be defined as the logical or mathematical model for the organisation of data elements in the computer memory.\n'
        'Such as array in "c" language.'
        'In an array the data is stored in a sequential order.'
        'We can say that array store the data elements in a continuous manner.'
        'The organisation of data is done with the help of an array of data structure.'
        'The data structure is not a programming language like c,c++,java etc..'
        'It is a set of algorithm that we can use in any programming language to structure the data in the memory.',
    style:
     TextStyle(
    color: Colors.black,
    fontSize: 20,)),

    TextSpan(
    text: '\n\nData structure = organized data + allowed operations',
    style:
     TextStyle(
        color: Colors.black,
        fontSize: 18),
    ),

    TextSpan(
    text: '\n\n\nO',
    style: TextStyle(color: Colors.purple, fontSize: 30),
    ),

    TextSpan(
    text: '4',
    style: TextStyle(
    color: Colors.purple,
    fontSize: 30,
    fontFeatures: [FontFeature.subscripts()]),
    ),
    ]),
    ),
    ));
  }
}

