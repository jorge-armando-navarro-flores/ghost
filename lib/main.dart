import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ghost'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:  Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Word fragment',
              style: TextStyle(
                fontSize: 49.0
              ),
            ),
            SizedBox(height: 5,),
            Text("Game status",),
            SizedBox(height: 10,),
            Row(
              children: [
                ActionButton(
                  text:"CHALLENGE",
                  onPressed: (){

                  },
                ),
                SizedBox(width: 10,),
                ActionButton(
                  text:"RESTART",
                  onPressed: (){

                  },
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}

class ActionButton extends StatelessWidget {
  final String? text;

  final VoidCallback? onPressed;

  ActionButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(text!,
          style: TextStyle(
            color: Colors.black
          ),
        ),
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFFD6D7D7),
      ),
    );
  }
}
