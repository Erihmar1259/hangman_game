import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;

class HangmanWords {
  int wordCounter = 0;
  List<int> _usedNumbers = [];
  List<String> _words = [];

  Future readWords() async {
    // String fileText = await rootBundle.loadString('res/hangman_words.txt');
    // _words = fileText.split('\n');
    _words=[
      "basketball",
      "volleyball",
      "soccer",
      "hockey",
      "tennis",
      "cricket",
      "football",
      "golf",
      "taekwondo",
      "handball",
      "rowing",
      "athletics",
      "badminton",
      "biathlon",
      "archery",
      "fencing",
      "boxing",
      "surfing",
      "swimming",
      "wrestling",
      "weightlifting",
      "curling",
      "baseball",
      "sepaktakraw",
      "futsal",
      "polo",
      "pingpong",
    ];
  }

  void resetWords() {
    wordCounter = 0;
    _usedNumbers = [];
//    _words = [];
  }

  // ignore: missing_return
  getWord() {
    wordCounter += 1;
    var rand = Random();
    int wordLength = _words.length;
    int randNumber = rand.nextInt(wordLength);
    bool notUnique = true;
    if (wordCounter - 1 == _words.length) {
      notUnique = false;
      return '';
    }
    while (notUnique) {
      if (!_usedNumbers.contains(randNumber)) {
        notUnique = false;
        _usedNumbers.add(randNumber);
        return _words[randNumber];
      } else {
        randNumber = rand.nextInt(wordLength);
      }
    }
  }

  String getHiddenWord(int wordLength) {
    String hiddenWord = '';
    for (int i = 0; i < wordLength; i++) {
      hiddenWord += '_';
    }
    return hiddenWord;
  }
}
