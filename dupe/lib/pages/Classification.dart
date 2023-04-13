import 'package:flutter/material.dart';
import 'package:dupe/widgets/NavDrawer.dart';
import 'package:dupe/pages/Linear.dart';
import 'package:dupe/pages/Nonlinear.dart';


void main() => runApp(const Classification());

class Classification extends StatelessWidget {
  const Classification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),

      home: Scaffold(

        drawer: NavDrawer(),
        appBar: AppBar(

        ),
        body:Card(

          child: Column(

            children: <Widget>[

              Text( "Classification of Data Structure\n",style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold,)),
              Text( "There are two types of data structure available for programming purpose.\n",style: TextStyle(color: Colors.black, fontSize: 20)),
              ListTile(

                  title: Text("1. Premitive data structure\n",style: TextStyle(color: Colors.black, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Linear()),
                    );
                  }
              ),

              ListTile(

                  title: Text('2. Non-premitive data structure',style: TextStyle(color: Colors.black, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Linear()),
                    );
                  }
              ),
              Image.asset("assets/images/classification.png"),
              ListTile(

                  title: Text('* Linear data structure',style: TextStyle(color: Colors.black, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Linear()),
                    );
                  }
              ),

              ListTile(

                  title: Text('* Non Linear data structure',style: TextStyle(color: Colors.black, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Nonlinear()),
                    );
                  }
              ),

            ],
          ),
        ),















      )
    );
  }
}