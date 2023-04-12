import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:home_router/no_internet.dart';

import 'mobile_network.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.active) {
              if (snapShot.data == ConnectivityResult.wifi) {
                return const WebviewScaffold(
                  url: 'http://192.168.1.1',
                  withJavascript: true,
                  withLocalStorage: true,
                  withZoom: true,
                  ignoreSSLErrors: true, // Disable SSL certificate checks
                );
              } else if (snapShot.data == ConnectivityResult.mobile) {
                return const MobileNetworkOffScreen();
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
