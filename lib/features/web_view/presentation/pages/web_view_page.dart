import 'package:flutter_getx_starter/common_widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/web_view_page_controller.dart';

class WebViewPage extends StatefulWidget {
  static const routeName = '/web_view';
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewPageController webViewPageController;

  var parameters =Get.parameters;

  @override
  void initState() {
    if (Get.isRegistered<WebViewPageController>()) {
      webViewPageController = Get.find();
    } else {
      webViewPageController = Get.put(WebViewPageController());
    }

    super.initState();
  }

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("${Get.parameters['url']}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppBar(title: 'fff',),
        ),
        // drawer: const AppDrawer(),
        body: WebViewWidget(controller: controller));
  }
}
