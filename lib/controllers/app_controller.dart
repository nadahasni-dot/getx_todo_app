import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/data/local/local_storage.dart';

class AppController extends GetxController {
  Rx<Locale> preferredLocale = const Locale('id', 'ID').obs;
  RxBool isDarkMode = false.obs;

  void loadPreferredLocale() async {
    final locale = await LocalStorage.getPreferredLocale();
    preferredLocale.value = locale;
    Get.updateLocale(locale);
  }

  void loadPreferredTheme() async {
    isDarkMode.value = await LocalStorage.checkIsDarkMode();
  }

  void changeTheme(bool isDark) {
    LocalStorage.setDarkMode(isDark);
    isDarkMode.value = isDark;
  }

  void changePreferredLocale(String locale) {
    LocalStorage.setPreferredLocale(locale);

    Locale selectedLocale = const Locale('id', 'ID');

    if (locale == 'en') {
      selectedLocale = const Locale('en', 'US');
    }

    preferredLocale.value = selectedLocale;

    Get.updateLocale(selectedLocale);
  }
}
