import 'package:kasun_hasanga_blott/features/home/presentation/model/news_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../core/network/client.dart';
import '../../../../core/shared_preferences.dart';

class HomePageController extends GetxController {
  SharedPref sharedPref = SharedPref();
  final storage = const FlutterSecureStorage();
  Clinet client = Clinet();
  // Define the RxList to hold your news articles
  RxList<NewsResponseModel> newsResponseModel = <NewsResponseModel>[].obs;


  Future<bool> getGeneralCategoryNews({
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) async {
    try {
      // Perform the API call
      dio.Response? response = await client.get(
        'news?category=general&token=cskehn1r01qn1f3vjta0cskehn1r01qn1f3vjtag',
        showError: true,
        isAuthAvailable: false,
        scaffoldKey: scaffoldKey,
      );

      // Ensure the response data is a List
      if (response?.data is List) {
        // Clear previous data
        newsResponseModel.clear();
        // Parse the JSON list into the RxList
        newsResponseModel.addAll(NewsResponseModel.fromJsonList(response!.data));
        return true;
      } else {
        print("Unexpected data format: ${response?.data}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}