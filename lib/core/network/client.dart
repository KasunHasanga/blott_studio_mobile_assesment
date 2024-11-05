import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/helper.dart';
import '../error/logger.dart';
import '../shared_preferences.dart';

class Clinet {
  SharedPref sharedPref = SharedPref();
  static BaseOptions opts = BaseOptions(
    ///todo need to define
    baseUrl: "https://finnhub.io/api/v1/",
    responseType: ResponseType.json,
    // connectTimeout: Duration(microseconds: 30000),
    // receiveTimeout: Duration(microseconds: 30000),
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(onRequest: (options, handler) {
          log("🐛 REQUEST URI: " + options.uri.toString());
          log("🐛 REQUEST QUERY: " + options.queryParameters.toString());
          //log("🐛 REQUEST DATA: "+options.data.toString());
        }, onResponse: (response, handler) {
          log("🐛 RESPONSE CODE: " + response.statusCode.toString());
          log("🐛 RESPONSE MESSAGE: " + response.statusMessage.toString());
          log("🐛 RESPONSE DATA: " + response.data.toString());
        }, onError: (DioException error, handler) {
          log("🐛 RESPONSE ERROR: " + error.error.toString());
        }),
      );
  }

  // static dynamic requestInterceptor(RequestOptions options) async {
  //   // Get your JWT token
  //   const token = '';
  //   options.headers.addAll({"Authorization": "Bearer: $token"});
  //   return options;
  // }

  static final dio = createDio();
  // static final baseAPI = addInterceptors(dio);
  Helper helper = Helper();

  Future<Response?> get(String url,
      {Map<String, dynamic>? query,
      dynamic data = null,
      required GlobalKey<ScaffoldState> scaffoldKey,}) async {
    try {

      Response? response = await dio.get(url, queryParameters: query);
      Logger.Yellow.log(
          "🐛 RESPONSE statusCode " + response.statusCode.toString());
      Logger.Blue.log("🐛 REQUEST URL " + url);
      Logger.Blue.log("🐛 REQUEST URL " +
          response.realUri.host +
          response.realUri.path +
          response.realUri.query);
      if (query != null) {
        Logger.Blue.log(
            "🐛 REQUESt query " + jsonDecode(jsonEncode(query)).toString());
      }
      if (data != null) {
        Logger.Blue.log(
            "🐛 REQUESt data " + jsonDecode(jsonEncode(data)).toString());
      }
      Logger.Blue.log("🐛 RESPONSE data " + response.data.toString());
      return response;
    } on DioException catch (e){
      return e.response;
    }catch (e) {
     print(e.toString());
      Logger.Red.log("🐛 RESPONSE ERROR: " + e.toString());
    }
  }

  // Future<Response?> post(String url,
  //     {Map<String, dynamic>? query = null,
  //     dynamic data = null,
  //     required GlobalKey<ScaffoldState> scaffoldKey,
  //     bool isAuthAvailable = false,
  //     bool showError = true}) async {
  //   try {
  //     if (isAuthAvailable) {
  //       String token =
  //           await sharedPref.readSingle(ShardPrefKey.userToken) ?? "";
  //       dio.options.headers["Authorization"] = "Bearer $token";
  //       print("Bearer $token");
  //     }
  //
  //     Response response =
  //         await dio.post(url, queryParameters: query, data: data);
  //     Logger.Yellow.log(
  //         "🐛 RESPONSE statusCode " + response.statusCode.toString());
  //     Logger.Blue.log("🐛 REQUEST URL " + url);
  //     Logger.Blue.log("🐛 REQUEST URL " +
  //         response.realUri.host +
  //         response.realUri.path +
  //         response.realUri.query);
  //     if (query != null) {
  //       Logger.Blue.log(
  //           "🐛 REQUESt query " + jsonDecode(jsonEncode(query)).toString());
  //     }
  //     if (data != null) {
  //       Logger.Blue.log(
  //           "🐛 REQUESt data " + jsonDecode(jsonEncode(data)).toString());
  //     }
  //     Logger.Blue.log("🐛 RESPONSE data " + response.data.toString());
  //     return response;
  //   } on DioException catch (e) {
  //     if (showError) {
  //       if (e.response?.statusCode == 404 || e.response?.statusCode == 400 ||e.response?.statusCode == 401 ||e.response?.statusCode ==422) {
  //         // noNetWorkBottomSheetOpen(scaffoldKey, title: 'Error'.tr, description: e.response?.data["error"]);
  //         if(e.response!=null && e.response!.data!=null && e.response!.data["error"]!=null){
  //           helper.showDefaultAlert(lan.Get.context!, e.response!.data["error"].toString());
  //         }else if(e.response!=null && e.response!.data!=null && e.response!.data["errors"]!=null){
  //           helper.showDefaultAlert(lan.Get.context!, e.response!.data["errors"].toString());
  //         }
  //         // return e.response;
  //       }
  //       // else if (e.type == DioExceptionType.connectionError) {
  //       //   noNetWorkBottomSheetOpen(scaffoldKey);
  //       // } else {
  //       //   print(e.response?.data);
  //       //   noNetWorkBottomSheetOpen(scaffoldKey,
  //       //       title: 'sys_error_t'.tr, description: 'sys_error_d'.tr);
  //       // }
  //     }
  //     Logger.Red.log("🐛 RESPONSE ERROR: " + e.toString());
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }
  //
  // Future<Response?> put(String url,
  //     {Map<String, dynamic>? query = null,
  //     dynamic data = null,
  //       bool isAuthAvailable = false,
  //     required GlobalKey<ScaffoldState> scaffoldKey}) async {
  //   try {
  //     if (isAuthAvailable) {
  //
  //       String token =
  //           await sharedPref.readSingle(ShardPrefKey.userToken) ?? "";
  //       print(token);
  //       print(data);
  //       dio.options.headers["Authorization"] = "Bearer $token";
  //     }
  //     Response? response =
  //     await dio.put(url, queryParameters: query, data: data);
  //     Logger.Yellow.log(
  //         "🐛 RESPONSE statusCode " + response.statusCode.toString());
  //     Logger.Blue.log("🐛 REQUEST URL " + url);
  //     Logger.Blue.log("🐛 REQUEST URL " +
  //         response.realUri.host +
  //         response.realUri.path +
  //         response.realUri.query);
  //     if (query != null) {
  //       Logger.Blue.log(
  //           "🐛 REQUESt query " + jsonDecode(jsonEncode(query)).toString());
  //     }
  //     if (data != null) {
  //       Logger.Blue.log(
  //           "🐛 REQUESt data " + jsonDecode(jsonEncode(data)).toString());
  //     }
  //     Logger.Blue.log("🐛 RESPONSE data " + response.data.toString());
  //     return response;
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 404 || e.response?.statusCode == 400 ||e.response?.statusCode ==  401|| e.response?.statusCode ==  500) {
  //       // noNetWorkBottomSheetOpen(scaffoldKey, title: 'Error'.tr, description: e.response?.data["error"]);
  //       if(e.response!=null && e.response!.data!=null && e.response!.data["error"]!=null){
  //         helper.showDefaultAlert(lan.Get.context!, e.response!.data["error"].toString());
  //       }
  //     }
  //     Logger.Red.log("🐛 RESPONSE ERROR: " + e.toString());
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }
  //
  // Future<Response?> deleteHTTP(String url,
  //     {Map<String, dynamic>? query = null,
  //     dynamic data = null,
  //     required GlobalKey<ScaffoldState> scaffoldKey}) async {
  //   try {
  //     String token =
  //         await sharedPref.readSingle(ShardPrefKey.userToken) ?? "";
  //     dio.options.headers["Authorization"] = "Bearer $token";
  //
  //     Response response =
  //         await dio.delete(url, queryParameters: query, data: data);
  //     Logger.Yellow.log(
  //         "🐛 RESPONSE statusCode " + response.statusCode.toString());
  //     Logger.Blue.log("🐛 REQUEST URL " + url);
  //     Logger.Blue.log("🐛 REQUEST URL " +
  //         response.realUri.host +
  //         response.realUri.path +
  //         response.realUri.query);
  //     if (query != null) {
  //       Logger.Blue.log(
  //           "🐛 REQUESt query " + jsonDecode(jsonEncode(query)).toString());
  //     }
  //     if (data != null) {
  //       Logger.Blue.log(
  //           "🐛 REQUESt data " + jsonDecode(jsonEncode(data)).toString());
  //     }
  //     Logger.Blue.log("🐛 RESPONSE data " + response.data.toString());
  //     return response;
  //   }  on DioException catch (e) {
  //
  //       if (e.response?.statusCode == 404 || e.response?.statusCode == 400 ||e.response?.statusCode ==  401) {
  //         // noNetWorkBottomSheetOpen(scaffoldKey, title: 'Error'.tr, description: e.response?.data["error"]);
  //         if(e.response!=null && e.response!.data!=null && e.response!.data["error"]!=null){
  //           helper.showDefaultAlert(lan.Get.context!, e.response!.data["error"].toString());
  //         }
  //       }
  //       // else if (e.type == DioExceptionType.connectionError) {
  //       //   noNetWorkBottomSheetOpen(scaffoldKey);
  //       // } else {
  //       //   print(e.response?.data);
  //       //   noNetWorkBottomSheetOpen(scaffoldKey,
  //       //       title: 'sys_error_t'.tr, description: 'sys_error_d'.tr);
  //       // }
  //
  //     Logger.Red.log("🐛 RESPONSE ERROR: " + e.toString());
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }
}
