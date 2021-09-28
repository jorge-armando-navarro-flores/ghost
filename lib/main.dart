import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghost/models/simple_dictionary.dart';

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

  TextEditingController controller = TextEditingController();
  SimpleDictionary? simpleDictionary;
  String gameStatus = "";
  bool userTurn = true;


  void onStart() async{
    String data = await rootBundle.loadString("text_files/words.txt");
    List<String> wordList = data.split('\n');
    // print(wordList);
    simpleDictionary = SimpleDictionary(wordList);
    setState(() {
      gameStatus = userTurn? "User turn": "Computer turn";
    });
  }

  void computerTurn(String fragment){
    setState(() {
      gameStatus = "Computer turn";
      userTurn = false;
    });

    if(fragment.length >=4 && simpleDictionary!.isWord(fragment)){
      setState(() {
        gameStatus = "Computer challenge and wins because user wrote a word";
      });
      return;
    }
    


      Future.delayed(const Duration(milliseconds: 2000), ()
    {
      String computerWord = simpleDictionary!.getAnyWordStartingWith(fragment);
      if(computerWord != "not found"){
        print(fragment.length);
        print(computerWord.length);
        final yourText = fragment.length < computerWord.length-1? computerWord[fragment.length]: computerWord[computerWord.length-1];
      print(computerWord);

      setState(() {
        userTurn = true;
        gameStatus = "User turn";
        controller.value = controller.value.copyWith(
          text: controller.text + yourText,
          selection: TextSelection.collapsed(
            offset: controller.value.selection.baseOffset + yourText.length,),
        );
      });
    }
      });





  }


  @override
  void initState(){
    super.initState();
    onStart();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:  simpleDictionary == null? CircularProgressIndicator():
      Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              readOnly: !userTurn,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none

              ),
              style: TextStyle(
                fontSize: 49.0,
              ),

              onChanged: (value){
                computerTurn(value);
              },
            ),
            SizedBox(height: 5,),
            Text(gameStatus),
            SizedBox(height: 10,),
            Row(
              children: [
                ActionButton(
                  text:"CHALLENGE",
                  onPressed: (){
                    print(simpleDictionary!.getAnyWordStartingWith("hell"));
                  },
                ),
                SizedBox(width: 10,),
                ActionButton(
                  text:"RESTART",
                  onPressed: (){
                    controller.clear();
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
