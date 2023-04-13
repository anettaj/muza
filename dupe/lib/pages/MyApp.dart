import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  String? categoryValue;
  @override
  State<Homepage> createState() => _HomepageState();
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50).copyWith(
                            bottomRight: Radius.circular(0), topLeft: Radius.circular(0)),
                        color: Colors.green.shade100),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          iconSize: 30,
                          borderRadius: BorderRadius.circular(20)
                              .copyWith(topLeft: Radius.circular(0)),
                          isExpanded: true,
                          hint: Text('Select any item', style: TextStyle(fontSize: 15)),
                          value: categoryValue,
                          items: [
                            DropdownMenuItem(
                                value: 'Sports',
                                child: Text('Sports',
                                    style: TextStyle(fontSize: 15, color: Colors.black45))),
                            DropdownMenuItem(
                                value: 'Tech',
                                child: Text('Tech',
                                    style: TextStyle(fontSize: 15, color: Colors.black45))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              categoryValue = val.toString();
                            });
                          }),
                    ),
                  ),
                )
            )
        )
    );
  }
}