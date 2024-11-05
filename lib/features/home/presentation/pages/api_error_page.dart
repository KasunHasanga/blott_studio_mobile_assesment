import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widget/app_bar.dart';
import '../../../../config/constants.dart';
import '../../../../config/fonts.dart';
import '../controller/home_page_controller.dart';

class ApiErrorPage extends StatefulWidget {
  static const routeName = '/api_error';
  const ApiErrorPage({super.key});

  @override
  State<ApiErrorPage> createState() => _ApiErrorPageState();
}

class _ApiErrorPageState extends State<ApiErrorPage> {
  late HomePageController homePageController;

  @override
  void initState() {
    if (Get.isRegistered<HomePageController>()) {
      homePageController = Get.find();
    } else {
      homePageController = Get.put(HomePageController());
    }

    super.initState();
  }

  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MainAppBar(
            title: 'Hey ${homePageController.userName}'.tr,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Get.arguments,
                  style: AppFonts.styleWithGilroyMediumText(
                      color: Theme.of(context).colorScheme.onSurface,
                      fSize: FontSizeValue.fontSize11),
                )
              ],
            ),
          ),
        ));
  }
}
