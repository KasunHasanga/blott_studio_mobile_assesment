import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';

import '../common_widget/default_alert_view.dart';

NumberFormat oCcy = NumberFormat("#,##0.00", "da_DK");

class Helper {
  static final Helper _helper = Helper._internal();

  factory Helper() {
    return _helper;
  }

  Helper._internal();

  showDefaultAlert(BuildContext context, String message, {Callback? action}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DefaultAlertView(
              title: message,
              actionTitle: "ok".tr,
              onPressed: action ??
                  () {
                    Get.back();
                  });
        });
  }
}
