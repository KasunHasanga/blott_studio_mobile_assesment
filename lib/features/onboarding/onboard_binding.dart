import 'package:kasun_hasanga_blott/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }

}