import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: themeLight,
      darkTheme: themeDark,
      debugShowCheckedModeBanner: false,
      title: "Alquran Apps",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
