import 'package:kasun_hasanga_blott/features/web_view/presentation/controller/web_view_page_controller.dart';
import 'package:get/get.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewPageController>(() => WebViewPageController());
  }
}
