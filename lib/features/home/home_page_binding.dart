
import 'package:kasun_hasanga_blott/features/home/presentation/controller/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }

}