import 'package:get/get.dart';

import '../features/home/home_page_binding.dart';
import '../features/home/presentation/pages/api_error_page.dart';
import '../features/home/presentation/pages/home_page.dart';

import '../features/onboarding/onboard_binding.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/onboarding/presentation/pages/sign_in_page.dart';
import '../features/onboarding/presentation/pages/splash.dart';
import '../features/web_view/presentation/pages/web_view_page.dart';
import '../features/web_view/web_view_binding.dart';

class Routers {
  static final route = [
    GetPage(
        name: SplashPage.routeName,
        page: () => const SplashPage(),
        bindings: [OnBoardingBinding()]),

    GetPage(
        name: SignInPage.routeName,
        page: () => const SignInPage(),
        bindings: [OnBoardingBinding()]),

    //onboarding Page
    GetPage(
        name: OnboardingPage.routeName,
        page: () => const OnboardingPage(),
        bindings: [OnBoardingBinding()]),

    //Home Page
    GetPage(
        name: HomePage.routeName,
        page: () => const HomePage(),
        bindings: [HomePageBinding()]),

    GetPage(
        name: ApiErrorPage.routeName,
        page: () => const ApiErrorPage(),
        bindings: [HomePageBinding()]),

    //Web View page
    GetPage(
        name: WebViewPage.routeName,
        page: () => const WebViewPage(),
        bindings: [WebViewBinding()]),
  ];
}
