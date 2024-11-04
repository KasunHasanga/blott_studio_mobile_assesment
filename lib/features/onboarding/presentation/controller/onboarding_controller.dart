import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kasun_hasanga_blott/features/home/presentation/pages/home_page.dart';

import '../../../../config/constants.dart';
import '../../../../core/shared_preferences.dart';
import '../pages/onboarding_page.dart';
import '../pages/sign_in_page.dart';


class OnBoardingController extends GetxController {
  SharedPref sharedPref = SharedPref();
  final storage = const FlutterSecureStorage();
  RxString selectedLanguage ="si".obs;

  @override
  void onInit() {

    super.onInit();
  }

  checkSessionStatus() async {
    await Future.delayed(const Duration(seconds: 5), () async {
      if (await sharedPref.check(ShardPrefKey.appLocale)) {
        String currentLocale = await sharedPref.readSingle(ShardPrefKey.appLocale);
        if (kDebugMode) {
          print(currentLocale);
        }
        var locale = Locale(currentLocale);
        // if (currentLocale == "sv-SE") {
        //   selectedLanguage.value = countryLanguage[2];
        // } else if (currentLocale == "nb-NO") {
        //   selectedLanguage.value = countryLanguage[1];
        // } else if (currentLocale == "da-DK") {
        //   selectedLanguage.value = countryLanguage[0];
        // }
        changeLanguage(locale);
      } else {
        var locale = const Locale('en');

        // _helper.changeLanguage(locale);
      }

        if (await storage.containsKey(key: ShardPrefKey.userFirstName)) {
          Get.off(() => const HomePage());
        } else {
          Get.off(() => const SignInPage());
        }

    });
  }

  ///
  /// Set App Language
  void changeLanguage(Locale selectedLocale) {
    sharedPref.saveSingle(ShardPrefKey.appLocale, selectedLocale.languageCode);
    Get.updateLocale(selectedLocale);
    if (selectedLocale.languageCode == "si") {
      selectedLanguage.value ="si";
    } else if (selectedLocale.languageCode == "en") {
      selectedLanguage.value = "en";
    }
  }

  void saveUserInfo(String firstName,String lastName)async{
   await sharedPref.saveSingle(ShardPrefKey.userFirstName, firstName);
   await sharedPref.saveSingle(ShardPrefKey.userLastName, lastName);
   Get.toNamed(OnboardingPage.routeName);
  }
}
