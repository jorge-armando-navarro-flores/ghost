import 'package:ghost/models/trie_node.dart';

class FastDictionary{
 TrieNode root = TrieNode();
 bool userStarted;

  FastDictionary(List<String> words, this.userStarted){
    for(String word in words){
      root.addWord(word);
    }
  }

  bool isWord(String word) {
    return root.contains(word);
  }

  String getAnyWordStartingWith(String prefix){
    return root.getAnyWordStartingWith(prefix);
  }

  String getGoodWordStartingWith(String prefix) {
    return root.getGoodWordStartingWith(prefix);
  }

  void setStart(bool started){
    userStarted = started;
  }


}