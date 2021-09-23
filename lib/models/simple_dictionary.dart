import 'package:flutter/services.dart';

class SimpleDictionary{
  List<String> words;

  SimpleDictionary(this.words);

  bool isWord(String word) {
    return words.contains(word);
  }

  String getAnyWordStartingWith(String prefix){
    int left = 0;
    int right = words.length - 1;
    int middle = 0;

    while(left <= right){
      middle = (left + right) ~/ 2;
      if(words[middle].toLowerCase().substring(0, prefix.length).compareTo(prefix.toLowerCase()) == 0){
        return words[middle];
      } else if(words[middle].toLowerCase().compareTo(prefix.toLowerCase()) == -1){
        left = middle + 1;
      }
      else{
        right = middle - 1;
      }
    }

    return "not found";

  }

  // String getGoodWordStartingWith(String prefix) {
  //   String? selected;
  //   return selected!;
  // }


}