import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../utils/util.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({Key? key}) : super(key: key);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final String url = Get.arguments['url'] as String;

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  RxInt index = 1.obs;
  RxDouble progress = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => webViewController?.reload(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(7),
          child: Obx(() => progress.value < 1.0 ? LinearProgressIndicator(value: progress.value) : const SizedBox()),
        ),
      ),
      body: Obx(() => IndexedStack(
            index: index.value,
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(url)),
                onLoadStart: (_, __) => index.value = 1,
                onLoadStop: (_, __) => index.value = 0,
                onLoadError: (controller, url, code, message) {
                  Get.back();
                  Utils.showSnackBar(
                    'Error to load the page',
                    message,
                    Icons.error,
                    color: Colors.red,
                  );
                },
                onWebViewCreated: (controller) => webViewController = controller,
                onLoadHttpError: (controller, failingUrl, code, message) {
                  Get.snackbar(
                    'Error to load the page',
                    'Please try again later or contact the administrator',
                    icon: const Icon(Icons.error),
                    margin: const EdgeInsets.all(10),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white54,
                  );
                  Get.dialog(
                    CupertinoAlertDialog(
                      title: const Text('Error'),
                      content: Text('$message ($code)'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('Ok'),
                          onPressed: () {
                            if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
                            Get.back();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    barrierDismissible: false,
                    name: 'error',
                    useSafeArea: true,
                    barrierColor: Get.theme.primaryColor,
                  );
                },
                onConsoleMessage: (_, msg) => Get.log(msg.message),
                onProgressChanged: (_, progress) => this.progress.value = progress / 100,
              ),
              Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  semanticsLabel: 'Loading web page...',
                ),
              ),
            ],
          )),
    );
  }
}
