import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // WebViewScreen
          onNavigationRequest: (request) {
            final uri = Uri.parse(request.url);

            if (uri.queryParameters.containsKey('session_id')) {
              final sessionId = uri.queryParameters['session_id'];
              Navigator.pop(context, sessionId); // نجاح الدفع
              return NavigationDecision.prevent;
            }

            // لو وصل لصفحة معينة فيها فشل
            if (uri.path.contains("payment-failed")) {
              Navigator.pop(context, "error: Payment failed"); // ارجع رسالة خطأ
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            debugPrint("Loading: $url");
          },
          onPageFinished: (url) {
            debugPrint("Finished: $url");
          },
          onWebResourceError: (error) {
            debugPrint("Error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web View")),
      body: WebViewWidget(controller: controller),
    );
  }
}
