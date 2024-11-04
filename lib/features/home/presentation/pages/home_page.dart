import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kasun_hasanga_blott/features/web_view/presentation/pages/web_view_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common_widget/app_bar.dart';

import '../../../../config/colors.dart';
import '../../../../config/constants.dart';
import '../../../../config/fonts.dart';
import '../../../../config/theme/theme_service.dart';
import '../controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;

  @override
  void initState() {
    if (Get.isRegistered<HomePageController>()) {
      homePageController = Get.find();
    } else {
      homePageController = Get.put(HomePageController());
    }
    getGeneralCategoryNews();
    initialization();
    super.initState();
  }
  bool isLightModeSelected = false;
  bool isAuto = false;

  void initialization() async {
    isAuto = ThemeService().getAutoThemeStatus();
    if (isAuto) {
      isLightModeSelected = ThemeService().currentThemeIsDark();
    } else {
      isLightModeSelected = ThemeService().getThemeStatus();
    }

    setState(() {});
  }

  bool isLoading = false;

  void getGeneralCategoryNews() async {
    setState(() {
      isLoading = true;
    });
    await homePageController
        .getGeneralCategoryNews(
      scaffoldKey: globalKey,
    )
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        extendBodyBehindAppBar:true,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MainAppBar(
            title: 'Hey Kasun Hasanga'.tr,
            otherAction: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLightModeSelected = !isLightModeSelected;
                    ThemeService().switchTheme(isLightModeSelected);
                    isAuto = false;
                    setState(() {});
                  });
                },
                child: isLightModeSelected
                    ? const Icon(
                  Icons.wb_sunny,
                  key: Key('sunny'),
                  color: Colors.white,
                  size: 30,
                )
                    : const Icon(
                  Icons.brightness_2,
                  key: Key('moon'),
                  color: Colors.black,
                  size: 30,
                ),
              ),
              const SizedBox(width: 15,)
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading?  CircularProgressIndicator(): ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homePageController.newsResponseModel.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "${homePageController.newsResponseModel[index].image}",
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                              errorWidget: (context, url, error) => Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100.0),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "",
                                  textAlign: TextAlign.center,
                                  style: AppFonts.styleWithGilroyMediumText(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fSize: FontSizeValue.fontSize11),
                                ),
                              ),
                              placeholder: (context, url) => const SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.kPrimary,
                                  ))),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${homePageController.newsResponseModel[index].source}",
                                        style:
                                            AppFonts.styleWithGilroyMediumText(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.6),
                                                fSize:
                                                    FontSizeValue.fontSize11),
                                      ),
                                      Text(
                                          DateFormat(DateTimeFormatType
                                                  .dayMonthYear)
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      homePageController
                                                              .newsResponseModel[
                                                                  index]
                                                              .datetime! *
                                                          1000))
                                              .toUpperCase(),
                                          style: AppFonts
                                              .styleWithGilroyMediumText(
                                                  color:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.6),
                                                  fSize: FontSizeValue
                                                      .fontSize11)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(WebViewPage.routeName,
                                          parameters: {
                                            "url":
                                                "${homePageController.newsResponseModel[index].url}",
                                            "headline":
                                            "${homePageController.newsResponseModel[index].headline}"
                                          });
                                    },
                                    child: Text(
                                        "${homePageController.newsResponseModel[index].headline}",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            AppFonts.styleWithGilroyMediumText(
                                                color:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.6),
                                                fSize:
                                                    FontSizeValue.fontSize20)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
