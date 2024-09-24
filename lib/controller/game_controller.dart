import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hangman_game/controller/home_controller.dart';
import 'package:hangman_game/screens/home_screen.dart';
import 'package:hangman_game/utils/color_const.dart';
import 'package:hangman_game/widgets/custom_text.dart';

import '../components/word_button.dart';
import '../utilities/alphabet.dart';
import '../utilities/hangman_words.dart';

class GameController extends GetxController {
  RxInt lives = 3.obs;
  RxInt remainingTime = 0.obs; // Remaining time in seconds for 1 hour
  Timer? countdownTimer;
  RxInt score = 0.obs;
  Alphabet englishAlphabet = Alphabet();
  RxString word = ''.obs;
  RxString hiddenWord = ''.obs;
  RxList<String> wordList = <String>[].obs;
  RxList<int> hintLetters = <int>[].obs;
  RxList<bool> buttonStatus = <bool>[].obs;
  RxBool hintStatus = false.obs;
  RxInt hangState = 0.obs;
  RxInt wordCount = 0.obs;
  RxBool finishedGame = false.obs;
  RxBool resetGame = false.obs;
  var box = GetStorage();
  final homeController = Get.put(HomeController());
  @override
  void onInit() {
    getScore();
   // if(!resetGame.value){
   //   initWords(homeController.hangmanWords);
   // }
    _loadGameData();
    super.onInit();
  }
  // Function to load saved game data
  void _loadGameData() async {

    int? savedLives = box.read("lives");
    int? lastPlayedTime = box.read("lastPlayedTime");

    if (savedLives != null) {
      lives.value = savedLives;
    }

    if (savedLives == 0 && lastPlayedTime != null) {
      // Start the cooldown if lives were 0
      _startCooldown();
    }
  }
  getScore(){
    score.value= box.read("score")??0;
    print("This is score ${score.value}");
  }
  void newGame(HangmanWords hangmanObject) {
    hangmanObject.resetWords();
    englishAlphabet = Alphabet();
    lives.value = 3;
    wordCount.value = 0;
    finishedGame.value = false;
    resetGame.value = false;
    initWords(hangmanObject);
  }

  Widget createButton(index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 6.0),
      child: Center(
        child: WordButton(
          buttonTitle: englishAlphabet.alphabet[index].toUpperCase(),
          onPress: buttonStatus[index] ? () => wordPress(index) : () {},
        ),
      ),
    );
  }

  void returnHomePage() {
    Get.to(() => HomeScreen());
  }

  void initWords(HangmanWords hangmanObject) {
    finishedGame.value = false;
    resetGame.value = false;
    hintStatus.value = true;
    hangState.value = 0;
    buttonStatus.value = List.generate(26, (index) {
      return true;
    });
    wordList.value = [];
    hintLetters.value = [];
    word.value = hangmanObject.getWord();
    if (word.isNotEmpty) {
      hiddenWord.value = hangmanObject.getHiddenWord(word.value.length);
    } else {
      returnHomePage();
    }

    for (int i = 0; i < word.value.length; i++) {
      wordList.add(word.value[i]);
      hintLetters.add(i);
    }
  }

  void wordPress(int index) {
    if (lives.value == 0) {
      returnHomePage();
    }

    if (finishedGame.value) {
      resetGame.value = true;

      return;
    }

    bool check = false;

    for (int i = 0; i < wordList.length; i++) {
      if (wordList[i] == englishAlphabet.alphabet[index]) {
        check = true;
        wordList[i] = '';
        hiddenWord.value =
            hiddenWord.value.replaceFirst(RegExp('_'), word.value[i], i);
      }
    }
    for (int i = 0; i < wordList.length; i++) {
      if (wordList[i] == '') {
        hintLetters.remove(i);
      }
    }
    if (!check) {
      hangState += 1;
    }

    if (hangState.value == 6) {
      finishedGame.value = true;
      lives.value -= 1;
      if (lives.value <=0) {
        var bestScore = box.read("score") ?? 0;
        box.write("lives", lives.value);
        print("Lives value ${lives.value}");
          // Save the current time when lives are lost

          box.write("lastPlayedTime", DateTime.now().millisecondsSinceEpoch);
          _startCooldown(); // Start 1-hour timer


        Get.defaultDialog(
          barrierDismissible: false,
          backgroundColor: whiteColor,
          cancel: GestureDetector(
            onTap: () {
              returnHomePage();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: secondaryColor,
              borderRadius: BorderRadius.circular(10.r)
              ),
              child: CustomText(
                text: 'home'.tr,
                fontSize: 14.sp,
                color: whiteColor,
              ),
            ),
          ),
          // confirm: GestureDetector(
          //   onTap: () {
          //    // newGame(homeController.hangmanWords);
          //     Get.back();
          //   },
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          //     decoration: BoxDecoration(
          //       color: secondaryColor,borderRadius: BorderRadius.circular(10.r)
          //     ),
          //     child: CustomText(
          //       text: 'again'.tr,
          //       fontSize: 14.sp,
          //       color: whiteColor,
          //     ),
          //   ),
          // ),
          title: 'game_over'.tr,

          titleStyle: TextStyle(
            fontSize: 15.sp,

          ),
          middleText: "${'your_score'.tr} ${wordCount.value}",
          middleTextStyle: TextStyle(
            fontSize: 16.sp,
            color: Colors.green
          ),
          content: CustomText(
            text: word.value,
            color: red,
            fontSize: 14.sp,
          ),
        );
      }
      else {
        // Function to save game data


          box.write("lives", lives.value);

        Get.defaultDialog(
          barrierDismissible: false,
          backgroundColor: whiteColor,
          confirm: GestureDetector(
            onTap: () {
              Get.back();
              initWords(homeController.hangmanWords);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: secondaryColor,borderRadius: BorderRadius.circular(10.r)
              ),
              child: CustomText(
                text: 'next'.tr,
                fontSize: 14.sp,
                color: whiteColor,
              ),
            ),
          ),
          title: 'sorry'.tr,
          content: CustomText(
            text: word.value,
            color: red,
            fontSize: 16.sp,
          ),
        );
      }
    }

    buttonStatus[index] = false;
    if (hiddenWord == word) {
      finishedGame.value = true;
      Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: whiteColor,
        confirm: GestureDetector(
          onTap: () {
            print("Confirm work");
            wordCount.value += 1;
            var bestScore = box.read("score") ?? 0;
            if (wordCount.value > bestScore) {
              box.write("score", wordCount.value);
            } else {}
            Get.back();
            initWords(homeController.hangmanWords);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: secondaryColor,borderRadius: BorderRadius.circular(10.r)
            ),
            child: CustomText(
              text: 'next'.tr,
              fontSize: 14.sp,
              color: whiteColor,
            ),
          ),
        ),
        title: 'congratulation'.tr,
        titleStyle: TextStyle(
          fontSize: 15.sp
        ),
        content: CustomText(
          text: word.value,
          color: green,
          fontSize: 16.sp,
        ),
      );
    }
  }
  void _startCooldown() async {

    int? lastPlayedTime = box.read("lastPlayedTime");

    if (lastPlayedTime != null) {
      DateTime lastTime = DateTime.fromMillisecondsSinceEpoch(lastPlayedTime);
      DateTime currentTime = DateTime.now();
      Duration difference = currentTime.difference(lastTime);

      // Check if 1 hour has passed
      if (difference.inHours >= 1) {
        resetLives(); // Reset lives if more than 1 hour has passed
      } else {
        // Start a countdown timer for the remaining time
        remainingTime.value = 3600 - difference.inSeconds;
        countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (remainingTime.value > 0) {
            remainingTime.value--;
          } else {
            resetLives();
            timer.cancel();
          }
        });
      }
    }
  }
  // Function to reset lives after the cooldown
  void resetLives() async {
    lives.value = 3;
    remainingTime.value = 0;
    countdownTimer?.cancel();

    box.remove("lastPlayedTime");
    box.write('lives', lives.value);
  }
  // Function to format remaining time into minutes and seconds
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}
