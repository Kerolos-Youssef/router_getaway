import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MobileNetworkOffScreen extends StatelessWidget {
  const MobileNetworkOffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please! turn off cellular network',
            style: TextStyle(
              color: Colors.green,
              fontSize: width / 18,
            ),
          ),
          Lottie.asset('assets/animation/no-wifi.json'),
        ],
      ),
    );
  }
}
