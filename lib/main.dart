import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/fast_dictionary.dart';

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
  FastDictionary? fastDictionary;
  String gameStatus = "";
  bool userTurn = Random().nextBool();

  void loadDictionary() async {
    String data = await rootBundle.loadString("text_files/words.txt");
    List<String> wordList = data.split('\n');
    // print(wordList);
    setState(() {
      fastDictionary = FastDictionary(wordList, userTurn);
    });
  }

  void onStart() {
    setState(() {
      if (userTurn) {
        gameStatus = "User Turn";
      } else {
        gameStatus = "Computer Turn";
        computerTurn("");
      }
      // gameStatus = userTurn? "User turn": "Computer turn";
    });
  }

  void computerTurn(String fragment) {
    if (fragment.length >= 4 && fastDictionary!.isWord(fragment)) {
      setState(() {
        if (userTurn) {
          gameStatus = "User challenge and wins because computer wrote a word";
        } else {
          gameStatus = "Computer challenge and wins because user wrote a word";
        }
      });
      return;
    } else if (userTurn) {
      setState(() {
        gameStatus = "computer wins because the fragment was not a word";
      });
      return;
    }

    Future.delayed(const Duration(milliseconds: 2000), () {
      String computerWord = fastDictionary!.getGoodWordStartingWith(fragment);
      print(computerWord);
      if (computerWord != "not found") {
        print(fragment.length);
        print(computerWord.length);
        final newLetter = fragment.length < computerWord.length - 1
            ? computerWord[fragment.length]
            : computerWord[computerWord.length - 1];
        print(computerWord);

        setState(() {
          userTurn = true;
          gameStatus = "User turn";
          controller.value = controller.value.copyWith(
            text: controller.text + newLetter,
            selection: TextSelection.collapsed(
              offset: controller.value.selection.baseOffset + newLetter.length,
            ),
          );
        });
      } else {
        setState(() {
          gameStatus =
              "computer challenge and wins because there is no word that begins with the fragment";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadDictionary();
    onStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: fastDictionary == null
            ? CircularProgressIndicator()
            : Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      // readOnly: !userTurn,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none),
                      style: TextStyle(
                        fontSize: 49.0,
                      ),

                      onChanged: (value) {
                        setState(() {
                          gameStatus = "Computer turn";
                          userTurn = false;
                        });
                        computerTurn(value);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(gameStatus),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ActionButton(
                          text: "CHALLENGE",
                          onPressed: () {
                            computerTurn(controller.text);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ActionButton(
                          text: "RESTART",
                          onPressed: () {
                            controller.clear();
                            userTurn = Random().nextBool();
                            fastDictionary!.setStart(userTurn);
                            print(fastDictionary!.userStarted);
                            onStart();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ));
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
      child: Text(
        text!,
        style: TextStyle(color: Colors.black),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFFD6D7D7),
      ),
    );
  }
}
