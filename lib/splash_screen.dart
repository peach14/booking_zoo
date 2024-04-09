import 'package:booking_zoo/constants/asset/asset_phat.dart';
import 'package:booking_zoo/shared_components/loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 243, 243),
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          const Loading(),
          Image.asset(scale: 8, ImagePhat.zebra)
        ]),
      ),
    );
  }
}
