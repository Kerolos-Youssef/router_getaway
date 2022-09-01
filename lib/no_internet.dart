import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please! turn on Wifi',
            style: TextStyle(
              color: Colors.red,
              fontSize: width / 18,
            ),
          ),
          Lottie.asset('assets/animation/no-wifi.json'),
        ],
      ),
    );
  }
}
