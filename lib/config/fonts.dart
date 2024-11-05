import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFonts {
  static const roboto = 'Roboto';
  static const rubik = 'Rubik';

  /// Gilroy light style. Default font size is 10, default color White.
  static TextStyle styleWithRobotoSemiBoldText(
          {Color color = Colors.white, double fSize = 3.2}) =>
      TextStyle(
          fontSize: fSize * (Get.width * 0.01),
          color: color,
          fontWeight: FontWeight.w600,
          fontFamily: roboto);

  ///
  static TextStyle styleWithRobotoMediumText({
    Color color = Colors.white,
    double fSize = 3.2,
  }) =>
      TextStyle(
          fontSize: fSize * (Get.width * 0.01),
          color: color,
          fontWeight: FontWeight.w500,
          fontFamily: roboto);

  ///
  static TextStyle styleWithRobotoRegularText(
          {Color color = Colors.black, double fSize = 3.2}) =>
      TextStyle(
          fontSize: fSize * (Get.width * 0.01),
          color: color,
          fontFamily: roboto);

  ///
  static TextStyle styleWithRubikRegularText(
          {Color color = Colors.black, double fSize = 3.2}) =>
      TextStyle(
          fontSize: fSize * (Get.width * 0.01),
          color: color,
          fontFamily: rubik);

  ///
  static TextStyle styleWithRobotoBoldText(
          {Color color = Colors.black, double fSize = 3.2}) =>
      TextStyle(
          fontSize: fSize * (Get.width * 0.01),
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: roboto);

  
}
