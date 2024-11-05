import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kasun_hasanga_blott/features/web_view/presentation/pages/web_view_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
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
    homePageController.getInfo();
    isAuto = ThemeService().getAutoThemeStatus();
    if (isAuto) {
      isLightModeSelected = ThemeService().currentThemeIsDark();
    } else {
      isLightModeSelected = ThemeService().getThemeStatus();
    }

    setState(() {});
  }

  bool isLoading = false;
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);



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
    _refreshController.refreshCompleted();
  }

  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        extendBodyBehindAppBar: true,
        backgroundColor:isLightModeSelected?AppColors.kBlack: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                    'Hey ${homePageController.userName}'.tr,
                    style: AppFonts.styleWithRalewayBoldText(
                        color: Theme.of(context).colorScheme.onSurface,
                        fSize: FontSizeValue.fontSize32),
                  ),
                  Row(children: [  GestureDetector(
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
                    const SizedBox(
                      width: 15,
                    )],)
                ],),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh:()=> getGeneralCategoryNews(),
                    // onLoading: _onLoading,
                    child: isLoading
                         ? Container()
                         : homePageController.newsResponseModel.isNotEmpty
                             ? ListView.builder(
                                 shrinkWrap: true,
                                 physics: const AlwaysScrollableScrollPhysics(),
                                 itemCount:
                                     homePageController.newsResponseModel.length,
                                 itemBuilder: (context, index) {
                                   return Container(
                                     padding: const EdgeInsets.only(
                                         top: 16, bottom: 16),
                                     child: Row(
                                       children: [
                                         CachedNetworkImage(
                                           imageUrl:
                                               "${homePageController.newsResponseModel[index].image}",
                                           fit: BoxFit.cover,
                                           width: 100,
                                           height: 100,
                                           errorWidget: (context, url, error) =>
                                               Container(
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
                                               style: AppFonts
                                                   .styleWithRobotoMediumText(
                                                       color: Theme.of(context)
                                                           .colorScheme
                                                           .onSurface,
                                                       fSize: FontSizeValue
                                                           .fontSize11),
                                             ),
                                           ),
                                           placeholder: (context, url) =>
                                               const SizedBox(
                                                   height: 40,
                                                   width: 40,
                                                   child: Center(
                                                       child:
                                                           CircularProgressIndicator(
                                                     color: AppColors.kPrimary,
                                                   ))),
                                         ),
                                         const SizedBox(
                                           width: 16,
                                         ),
                                         Expanded(
                                           child: Column(
                                             crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                             mainAxisAlignment:
                                                 MainAxisAlignment.start,
                                             children: [
                                               Row(
                                                 mainAxisAlignment:
                                                     MainAxisAlignment
                                                         .spaceBetween,
                                                 children: [
                                                   Text(
                                                     "${homePageController.newsResponseModel[index].source}".toUpperCase(),
                                                     style: AppFonts
                                                         .styleWithRubikRegularText(
                                                             color: Theme.of(
                                                                     context)
                                                                 .colorScheme
                                                                 .onSurface
                                                                 .withOpacity(0.6),
                                                             fSize: FontSizeValue
                                                                 .fontSize11),
                                                   ),
                                                   Text(
                                                       DateFormat(
                                                               DateTimeFormatType
                                                                   .dayMonthYear)
                                                           .format(DateTime.fromMillisecondsSinceEpoch(
                                                               homePageController
                                                                       .newsResponseModel[
                                                                           index]
                                                                       .datetime! *
                                                                   1000))
                                                           .toUpperCase(),
                                                       style: AppFonts
                                                           .styleWithRubikRegularText(
                                                               color: Theme.of(
                                                                       context)
                                                                   .colorScheme
                                                                   .onSurface
                                                                   .withOpacity(
                                                                       0.6),
                                                               fSize: FontSizeValue
                                                                   .fontSize11)),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 8,
                                               ),
                                               GestureDetector(
                                                 onTap: () {
                                                   Get.toNamed(
                                                       WebViewPage.routeName,
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
                                                     overflow:
                                                         TextOverflow.ellipsis,
                                                     style: AppFonts
                                                         .styleWithRobotoRegularText(
                                                             color: Theme.of(
                                                                     context)
                                                                 .colorScheme
                                                                 .onSurface,
                                                             fSize: FontSizeValue
                                                                 .fontSize20)),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   );
                                 })
                             :  Text(
                       "Something went wrong. Please try again later.",
                       style: AppFonts.styleWithRubikRegularText(
                           color: Theme.of(context).colorScheme.onSurface,
                           fSize: FontSizeValue.fontSize16),
                     ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
