
import 'package:flutter_getx_starter/config/helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../core/network/client.dart';
import '../../../../core/shared_preferences.dart';


class WebViewPageController extends GetxController {
  SharedPref sharedPref = SharedPref();
  final storage = const FlutterSecureStorage();
  Clinet client = Clinet();

  Helper helper = Helper();



  @override
  void onInit() {
    // faqsGet();
    super.onInit();
  }

}
