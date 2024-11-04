import 'package:flutter/material.dart';
import 'package:kasun_hasanga_blott/features/home/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import '../../../../common_widget/app_button.dart';
import '../../../../config/colors.dart';
import '../../../../config/constants.dart';
import '../../../../config/fonts.dart';
import '../controller/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final formKeySignIn = GlobalKey<FormState>();

  late OnBoardingController onBoardingController;

  @override
  void initState() {
    if (Get.isRegistered<OnBoardingController>()) {
      onBoardingController = Get.find();
    } else {
      onBoardingController = Get.put(OnBoardingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                FittedBox(
                  child: Text(
                    'Get the most out of Blott ✅'.tr,
                    textAlign: TextAlign.start,
                    style: AppFonts.styleWithGilroyMediumText(
                        color: Theme.of(context).colorScheme.onSurface,
                        fSize: FontSizeValue.fontSize25),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Allow notifications to stay in the loop with your payments, requests and groups.'
                      .tr,
                  textAlign: TextAlign.center,
                  style: AppFonts.styleWithGilroyMediumText(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fSize: FontSizeValue.fontSize16),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Container(
              alignment: Alignment.center,
              height: 48,
              child: AppButton(
                buttonRadius: 24,
                backgroundColor: AppColors.kPrimary,
                title: "Continue".tr,
                action: () {
                  Get.offAllNamed(HomePage.routeName);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
