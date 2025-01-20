import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:home_router/no_internet.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'mobile_network.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WebViewController _webViewController;
  final String _url =
      'http://192.168.1.1'; // Replace with your router gateway URL
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Allow all URLs to load
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            print('Page started loading: $url');
            setState(() {
              _isLoading = true; // Show loading indicator
            });
          },
          onPageFinished: (url) {
            print('Page finished loading: $url');
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          },
          onWebResourceError: (error) {
            print('Web resource error: ${error.description}');
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_url)); // Load the initial URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Router Gateway'),
      ),
      body: SafeArea(
        child: StreamBuilder<List<ConnectivityResult>>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.active) {
              if (snapShot.hasData && snapShot.data!.isNotEmpty) {
                final connectivityResult = snapShot.data!.first;
                if (connectivityResult == ConnectivityResult.wifi) {
                  return Stack(
                    children: [
                      WebViewWidget(controller: _webViewController),
                      if (_isLoading)
                        const Center(
                          child:
                              CircularProgressIndicator(), // Show loading indicator
                        ),
                    ],
                  );
                } else if (connectivityResult == ConnectivityResult.mobile) {
                  return const MobileNetworkOffScreen();
                } else {
                  return const NoInternetScreen();
                }
              } else {
                return const NoInternetScreen();
              }
            } else {
              return const NoInternetScreen();
            }
          },
        ),
      ),
    );
  }
}

// class InAppWebViewScreen extends StatefulWidget {
//   final String url;
//
//   const InAppWebViewScreen({Key? key, required this.url}) : super(key: key);
//
//   @override
//   _InAppWebViewScreenState createState() => _InAppWebViewScreenState();
// }
//
// class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
//   late InAppWebViewController _webViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: WebUri(widget.url)),
//         initialSettings: InAppWebViewSettings(
//           javaScriptEnabled: true, // Enable JavaScript
//           useShouldOverrideUrlLoading: true, // Handle URL loading
//           mediaPlaybackRequiresUserGesture: false, // Allow media autoplay
//           allowFileAccessFromFileURLs: true, // Allow file access
//           allowUniversalAccessFromFileURLs: true, // Allow universal access
//           transparentBackground: true, // Transparent background
//           disableVerticalScroll: false, // Enable vertical scrolling
//           disableHorizontalScroll: false, // Enable horizontal scrolling
//           supportZoom: true, // Allow zooming
//           cacheEnabled: true, // Enable caching
//           domStorageEnabled: true, // Enable DOM storage
//           // Android-specific settings
//           useHybridComposition: true, // Improve performance on Android
//           allowContentAccess: true, // Allow content access
//           allowFileAccess: true, // Allow file access
//           builtInZoomControls: true, // Enable built-in zoom controls
//           displayZoomControls: false, // Hide zoom controls UI
//           useWideViewPort: true, // Use wide viewport
//           safeBrowsingEnabled: true, // Enable safe browsing
//           // iOS-specific settings
//           allowsInlineMediaPlayback: true, // Allow inline media playback
//           allowsBackForwardNavigationGestures:
//               true, // Enable swipe gestures for navigation
//           allowsLinkPreview: false, // Disable link preview on long-press
//           isFraudulentWebsiteWarningEnabled:
//               true, // Enable fraudulent website warnings
//         ),
//         onWebViewCreated: (controller) {
//           _webViewController = controller;
//         },
//         onLoadStart: (controller, url) {
//           print('Page started loading: $url');
//         },
//         onLoadStop: (controller, url) {
//           print('Page finished loading: $url');
//         },
//         onReceivedServerTrustAuthRequest: (controller, challenge) async {
//           return ServerTrustAuthResponse(
//               action: ServerTrustAuthResponseAction.PROCEED);
//         },
//         shouldOverrideUrlLoading: (controller, navigationAction) async {
//           return NavigationActionPolicy.ALLOW;
//         },
//         onConsoleMessage: (controller, consoleMessage) {
//           print('Console message: ${consoleMessage.message}');
//         },
//       ),
//     );
//   }
// }
