import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  runApp(
    GetMaterialApp(
<<<<<<< HEAD
      theme: box.read("themeDark") == null ? themeLight : themeDark,
=======
      theme: box.read("themeDark") == true ? themeDark : themeLight,
      darkTheme: themeDark,
>>>>>>> 9a7bb91 (upgrade to flutter 3.0.5)
      debugShowCheckedModeBanner: false,
      title: "Alquran Apps",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
