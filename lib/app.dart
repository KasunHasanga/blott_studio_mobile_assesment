import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/localization/translation.dart';
import 'config/routes.dart';
import 'config/theme/theme_service.dart';
import 'config/theme/themes.dart';
import 'features/onboarding/presentation/pages/splash.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  final String flavor;
  const App({super.key, required this.flavor});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeMode themeMode;

  @override
  void initState() {
    themeMode = ThemeService().theme;
    loadDotEnv();
    super.initState();
  }

  Future loadDotEnv() async {
    // To load the .env file contents into dotenv.
    // NOTE: fileName defaults to .env and can be omitted in this case.
    // Ensure that the filename corresponds to the path in step 1 and 2.
    await dotenv.load(fileName: ".env");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: SplashPage.routeName,
      getPages: Routers.route,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en'),
    );
  }
}
