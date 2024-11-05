import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kasun_hasanga_blott/config/helper.dart';
import 'package:kasun_hasanga_blott/features/home/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../common_widget/app_button.dart';
import '../../../../config/app_images.dart';
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
  Helper helper = Helper();

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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 98,
                  width: 98,
                  child: SvgPicture.asset(AllImages().svgNotificationIcon,
                      semanticsLabel: "svgNotificationIcongg"),
                ),
                const SizedBox(
                  height: 24,
                ),
                FittedBox(
                  child: Text(
                    'Get the most out of Blott ✅'.tr,
                    textAlign: TextAlign.start,
                    style: AppFonts.styleWithRobotoMediumText(
                        color: Theme.of(context).colorScheme.onSurface,
                        fSize: FontSizeValue.fontSize24),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Allow notifications to stay in the loop with your payments, requests and groups.'
                      .tr,
                  textAlign: TextAlign.center,
                  style: AppFonts.styleWithRobotoRegularText(
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
                fSize: FontSizeValue.fontSize16,
                backgroundColor: AppColors.kPrimary,
                title: "Continue".tr,
                action: () async {
                  final PermissionStatus status =
                      await Permission.notification.status;
                  if (status.isGranted) {
                    Get.offAllNamed(HomePage.routeName);
                  } else {
                   showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) =>
                                Theme(
                                  data: ThemeData.light(),
                                  child: CupertinoAlertDialog(
                                    title: Text(
                                      "“Blott” Would Like to Send You Notifications",
                                      style: AppFonts.styleWithRobotoSemiBoldText(
                                          color: AppColors.kBlack,
                                          fSize: FontSizeValue.fontSize16),
                                    ),
                                    content: Text(
                                      "Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.",
                                      style: AppFonts.styleWithRobotoRegularText(
                                          color: AppColors.kBlack,
                                          fSize: FontSizeValue.fontSize13),
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(

                                        child: Text(
                                          "Don’t Allow",
                                          style: AppFonts
                                              .styleWithRobotoRegularText(
                                                  color: AppColors.kBlue,
                                                  fSize:
                                                      FontSizeValue.fontSize13),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                          // Get.offAllNamed(HomePage.routeName);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        child: Text(
                                          "Allow",
                                          style:
                                              AppFonts.styleWithRobotoSemiBoldText(
                                                  color: AppColors.kBlue,
                                                  fSize:
                                                      FontSizeValue.fontSize13),
                                        ),
                                        onPressed: () async {
                                          await openAppSettings();
                                        },
                                      )
                                    ],
                                  ),
                                ));

                    // showDialog(
                    //   context: Get.context!,
                    //   builder: (BuildContext context) => AlertDialog(
                    //     title: Text(
                    //       "“Blott” Would Like to Send You Notifications",
                    //       style: AppFonts.styleWithRobotoSemiBoldText(
                    //         color: Colors.black,
                    //         fSize: FontSizeValue.fontSize16,
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //     content: Padding(
                    //       padding: const EdgeInsets.only(top: 8.0),
                    //       child: Text(
                    //         "Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.",
                    //         style: AppFonts.styleWithRobotoRegularText(
                    //           color: Colors.black,
                    //           fSize: FontSizeValue.fontSize13,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     actions: [
                    //       TextButton(
                    //         child: Text(
                    //           "Don't Allow",
                    //           style: AppFonts.styleWithRobotoRegularText(
                    //               color: AppColors.kBlue,
                    //               fSize: FontSizeValue.fontSize13),
                    //         ),
                    //         onPressed: () {
                    //           Get.back();
                    //           // Get.offAllNamed(HomePage.routeName);
                    //         },
                    //       ),
                    //       TextButton(
                    //         child: Text(
                    //           "Allow",
                    //           style: AppFonts.styleWithRobotoSemiBoldText(
                    //               color: AppColors.kBlue,
                    //               fSize: FontSizeValue.fontSize13),
                    //         ),
                    //         onPressed: () async {
                    //           // Add your notification permission request logic here
                    //           await openAppSettings();
                    //           // Navigator.of(context).pop();
                    //           // Get.back();
                    //           // Get.offAllNamed(HomePage.routeName);
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }

                  // Get.offAllNamed(HomePage.routeName);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
