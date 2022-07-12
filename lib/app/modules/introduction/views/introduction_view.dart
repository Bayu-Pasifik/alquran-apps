import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/routes/app_pages.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Al-Qur'an",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Text(
                "Sebegitu sibukkah anda sampai lupa membaca Al - Qur'an ?",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 300,
                height: 300,
                child: Lottie.asset(
                  "assets/lottie/introduction.json",
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                    color: Get.isDarkMode ? appNormalPurple : appWhite),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Get.isDarkMode ? appWhite : appNormalPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
            )
          ],
        ),
      ),
    );
  }
}
