import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kasun_hasanga_blott/features/home/presentation/model/news_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:kasun_hasanga_blott/features/home/presentation/pages/api_error_page.dart';
import '../../../../config/constants.dart';
import '../../../../core/network/client.dart';
import '../../../../core/shared_preferences.dart';

class HomePageController extends GetxController {
  SharedPref sharedPref = SharedPref();
  final storage = const FlutterSecureStorage();
  Clinet client = Clinet();
  // Define the RxList to hold your news articles
  RxList<NewsResponseModel> newsResponseModel = <NewsResponseModel>[].obs;

  RxString userName = "".obs;

  void getInfo() async {
    String firstName = await sharedPref.readSingle(ShardPrefKey.userFirstName);
    // String lastName = await sharedPref.readSingle(ShardPrefKey.userLastName);
    userName.value = firstName;
  }

  Future<bool> getGeneralCategoryNews({
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) async {
    try {
      // Perform the API call
      dio.Response? response = await client.get(
        'news?category=general&token=${dotenv.env['API_KEY']} d',
        scaffoldKey: scaffoldKey,
      );

      // Ensure the response data is a List
      if (response?.data is List) {
        // Clear previous data
        newsResponseModel.clear();
        // Parse the JSON list into the RxList
        newsResponseModel
            .addAll(NewsResponseModel.fromJsonList(response!.data));
        return true;
      } else {
        if (kDebugMode) {
          print("Unexpected data format: ${response?.data}");
        }
        Get.toNamed(ApiErrorPage.routeName,
            arguments: "${response?.data["error"]}");
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      Get.toNamed(ApiErrorPage.routeName,
          arguments: "Something went wrong. Please try again later.");
      return false;
    }
  }
}
