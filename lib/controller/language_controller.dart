import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../local_storage.dart';
import '../utils/enum.dart';


class LanguageController extends GetxController {
  final language = ''.obs;

  @override
  void onInit() {
    getLanguage();
    super.onInit();
  }

  void changeLanguage(String languageCode, String countryCode) {
    language.value = languageCode;

    Get.updateLocale(Locale(languageCode, countryCode));
    LocalStorage.instance.write(StorageKey.language.name, languageCode);
  }

  void getLanguage() {
    language.value = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.en.name;
  }
}
