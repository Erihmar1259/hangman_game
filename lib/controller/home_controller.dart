import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utilities/hangman_words.dart';

class HomeController extends GetxController {
  final HangmanWords hangmanWords = HangmanWords();
  var box = GetStorage();
  RxInt score=0.obs;
  @override
  void onInit() {
    getScore();
    hangmanWords.readWords();
    super.onInit();
  }

  getScore(){
   score.value= box.read('score')??0;
  }
}
