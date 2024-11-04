import 'package:flutter_getx_starter/features/web_view/presentation/controller/web_view_page_controller.dart';
import 'package:get/get.dart';

class WebViewBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WebViewPageController>(() => WebViewPageController());
  }

}