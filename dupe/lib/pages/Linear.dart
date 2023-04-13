import 'package:flutter/material.dart';
import 'package:dupe/widgets/NavDrawer.dart';

void main() => runApp(const Linear());

class Linear extends StatelessWidget {
  const Linear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'linear',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),

        home: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              title: Text('Linear data structure'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'Classification of Data Structure\n\n',
                      style: TextStyle(color: Colors.purple, fontSize: 30)),
                  TextSpan(
                      text: 'There are two types of data structure available for programming purpose.\n'
                          '\n1.Premitive data structure'
                          '\n2.Non-Premitive data structure\n\n',
                      style: TextStyle(color: Colors.purple, fontSize: 30))
                ]),
              ),
            )));
  }
}