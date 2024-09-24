import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_game/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController  = Get.put(SplashController());
    return Scaffold(
      body: Center(
        child:FlutterLogo(),
      ),
    );
  }
}
