import 'dart:math';

class TrieNode {
  Map children = {};
  String endSymbol = '*';

  void addWord(String word) {
    TrieNode node = this;
    for (int i = 0; i < word.length; i++) {
      String letter = word[i];
      if (!node.children.containsKey(letter)) {
        node.children[letter] = TrieNode();
      }
      node = node.children[letter];
    }
    node.children[endSymbol] = TrieNode();
  }

  bool contains(String word) {
    TrieNode node = this;
    for (int i = 0; i < word.length; i++) {
      String letter = word[i];
      if (!node.children.containsKey(letter)) {
        return false;
      }
      node = node.children[letter];
    }

    return node.children.containsKey(endSymbol);
  }

  void depthFirstSearch(List<String> words, {String s = "", String k = ""}) {
    s += k;
    children.forEach((k, v) {
      v.depthFirstSearch(words, s: s, k: k);
    });

    if (children.containsKey(endSymbol)) {
      words.add(s);
      return;
    }
  }

  String getAnyWordStartingWith(String prefix) {
    TrieNode node = this;
    List<String> words = [];
    for (int i = 0; i < prefix.length; i++) {
      String letter = prefix[i];
      if (!node.children.containsKey(letter)) {
        return "not found";
      }
      node = node.children[letter];
    }
    node.depthFirstSearch(words, s: prefix);

    return words[Random().nextInt(words.length)];
  }

  String getGoodWordStartingWith(String prefix) {
    TrieNode node = this;
    List<String> goodWords = [];
    List<String> badWords = [];
    for (int i = 0; i < prefix.length; i++) {
      String letter = prefix[i];
      if (!node.children.containsKey(letter)) {
        return "not found";
      }
      node = node.children[letter];
    }
    node.children.forEach((k, v) {
      if (!v.children.containsKey(endSymbol)) {
        v.depthFirstSearch(goodWords, s: prefix + k);
      }
    });

    if (goodWords.isEmpty) {
      node.depthFirstSearch(badWords, s: prefix);
      return badWords[Random().nextInt(badWords.length)];
    }
    return goodWords[Random().nextInt(goodWords.length)];
  }
}
