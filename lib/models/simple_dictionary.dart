import 'dart:math';



class SimpleDictionary {
  List<String> words;
  bool userStarted;

  SimpleDictionary(this.words, this.userStarted);

  bool isWord(String word) {
    return words.contains(word);
  }

  String getAnyWordStartingWith(String prefix) {
    int left = 0;
    int right = words.length - 1;
    int middle = 0;
    int prefixLength = 0;
    while (left <= right) {
      middle = (left + right) ~/ 2;
      prefixLength = prefix.length;
      if (prefixLength >= words[middle].length) {
        prefixLength = words[middle].length - 1;
      }
      if (words[middle]
              .toLowerCase()
              .substring(0, prefixLength)
              .compareTo(prefix.toLowerCase()) ==
          0) {
        return words[middle];
      } else if (words[middle].toLowerCase().compareTo(prefix.toLowerCase()) ==
          -1) {
        left = middle + 1;
      } else {
        right = middle - 1;
      }
    }

    return "not found";
  }

  String getGoodWordStartingWith(String prefix) {
    if (prefix.length == 0) {
      return words[Random().nextInt(words.length)][0];
    }
    int left = 0;
    int right = words.length - 1;
    int middle = 0;
    int prefixLength = 0;

    while (left <= right) {
      middle = (left + right) ~/ 2;
      prefixLength = prefix.length;
      if (prefixLength > words[middle].length) {
        prefixLength = words[middle].length - 1;
      }
      if (words[middle]
              .toLowerCase()
              .substring(0, prefixLength)
              .compareTo(prefix.toLowerCase()) ==
          0) {
        int start = middle;
        int end = middle;
        while (words[start]
                .toLowerCase()
                .substring(0, prefixLength)
                .compareTo(prefix.toLowerCase()) ==
            0) {
          start--;
          if (prefixLength > words[start].length) {
            start++;
            break;
          }
        }
        while (words[end]
                .toLowerCase()
                .substring(0, prefixLength)
                .compareTo(prefix.toLowerCase()) ==
            0) {
          end++;
          if (prefixLength > words[end].length) {
            break;
          }
        }

        List<String> possibleWords = [];
        for (String word in words.sublist(start + 1, end)) {
          if (word.length > prefixLength) {
            if (userStarted) {
              if (word.length % 2 == 1) {
                possibleWords.add(word);
              }
            } else if (word.length % 2 == 0) {
              possibleWords.add(word);
            }
          }
        }

        print(possibleWords);
        return possibleWords[Random().nextInt(possibleWords.length)];
      } else if (words[middle].toLowerCase().compareTo(prefix.toLowerCase()) ==
          -1) {
        left = middle + 1;
      } else {
        right = middle - 1;
      }
    }

    return "not found";
  }

  void setStart(bool started) {
    userStarted = started;
  }
}
