import 'package:flutter/material.dart';
import 'package:dupe/widgets/NavDrawer.dart';

void main() => runApp(const Nonlinear());

class Nonlinear extends StatelessWidget {
  const Nonlinear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'non linear data structure',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              title: Text('Non Linear data structure'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'Acid Sulfuric: ',
                      style: TextStyle(color: Colors.purple, fontSize: 30)),
                  TextSpan(
                      text: 'H',
                      style: TextStyle(color: Colors.purple, fontSize: 30))
                ]),
              ),
            )));
  }
}