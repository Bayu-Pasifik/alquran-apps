import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/juz.dart' as juz;
import 'package:my_alquran/app/data/models/surah.dart';
import 'package:my_alquran/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (controller.isDark.value == "true") {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Alquran Apps'),
        backgroundColor: Get.isDarkMode ? appWhite : appNormalPurple,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.SEARCH);
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      appWhite,
                      appLightPurple,
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Get.toNamed(Routes.LAST_READ);
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                              right: -40,
                              bottom: -50,
                              child: Container(
                                  width: 240,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(
                                      'assets/images/alquran.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Terakhir dibaca",
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Al-Fatihah",
                                  style: TextStyle(color: appWhite),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Juz 1| ayat 3",
                                  style: TextStyle(color: appWhite),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                appDarkPurple,
                                appLightPurple,
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(tabs: [
                Tab(
                  text: "Surah",
                ),
                Tab(
                  text: "Juz",
                ),
                Tab(
                  text: "Bookmark",
                ),
              ]),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder<List<Surah>>(
                    future: controller.getAllSurah(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Data Kosong"),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: surah);
                              },
                              leading: Obx(
                                () => Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(controller
                                                    .isDark.isTrue
                                                ? "assets/images/border_light.png"
                                                : "assets/images/border_dark.png"),
                                            fit: BoxFit.cover)),
                                    child: Center(
                                        child: Text(surah.number.toString()))),
                              ),
                              title: Text(
                                  "${surah.name?.transliteration!.id ?? "Error...."}"),
                              subtitle: Text(
                                  "${surah.numberOfVerses} ayat | ${surah.revelation!.id}"),
                              trailing:
                                  Text("${surah.name?.short ?? "Error...."}"),
                            );
                          },
                        );
                      }
                    },
                  ),
                  FutureBuilder<List<juz.Juz>>(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Data Kosong"),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              juz.Juz detailJuz = snapshot.data![index];
                              // !compare awal dan akhir surah yg ada di juz dengan juz yg di pilih
                              // ! pisahkan antara nama surah dengan nomor ayatnya
                              String starName =
                                  detailJuz.juzStartInfo?.split(" - ").first ??
                                      "";
                              String endName =
                                  detailJuz.juzEndInfo?.split(" - ").first ??
                                      "";
                              // ! buat penampung surah yg dipilih sehingga nanti nya datanya dapat di passing
                              List<Surah> surahList = [];
                              // ! buat penampung sementara syrah nya / raw data yg akan dibandingkan
                              List<Surah> tempSurahList = [];
                              // ! cek apakah akhir surat ada atau tidak kalau ada break
                              for (Surah item in controller.allSurah) {
                                tempSurahList.add(item);
                                if (item.name?.transliteration?.id == endName) {
                                  break;
                                }
                              }
                              for (Surah item
                                  in tempSurahList.reversed.toList()) {
                                surahList.add(item);
                                if (item.name?.transliteration?.id ==
                                    starName) {
                                  break;
                                }
                              }
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                    "juz": detailJuz,
                                    "surahList": surahList.reversed.toList()
                                  });
                                },
                                leading: Obx(
                                  () => Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(controller
                                                      .isDark.isTrue
                                                  ? "assets/images/border_light.png"
                                                  : "assets/images/border_dark.png"),
                                              fit: BoxFit.cover)),
                                      child:
                                          Center(child: Text("${index + 1}"))),
                                ),
                                title:
                                    Text("Juz ${detailJuz.juz ?? "Error...."}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Mulai Dari : ${detailJuz.juzStartInfo ?? "Error...."}",
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                    Text(
                                      "Sampai : ${detailJuz.juzEndInfo ?? "Error...."}",
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                              );
                            },
                          );
                        }
                      },
                      future: controller.getAllJuz()),
                  GetBuilder<HomeController>(
                    builder: (c) {
                      return FutureBuilder<List<Map<String, dynamic>>>(
                        future: c.getAllBookmark(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data?.length == 0) {
                            return Center(
                              child: Text("Belum ada bookmark"),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  print(data);
                                },
                                leading: Obx(
                                  () => Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(controller
                                                      .isDark.isTrue
                                                  ? "assets/images/border_light.png"
                                                  : "assets/images/border_dark.png"),
                                              fit: BoxFit.cover)),
                                      child:
                                          Center(child: Text("${index + 1}"))),
                                ),
                                // leading: Text("${index + 1}"),
                                title: Text(data["surah"]
                                    .toString()
                                    .replaceAll("+", "'")),
                                subtitle: Text(
                                    " Ayat : ${data["ayat"]} | Via : ${data["via"]}"),
                                trailing: IconButton(
                                    onPressed: () {
                                      c.deleteBookmark(data['id']);
                                    },
                                    icon: Icon(Icons.delete_forever)),
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeTheme();
        },
        child: Obx(() => Icon(
              Icons.color_lens,
              color: controller.isDark.isTrue ? appDarkPurple : appWhite,
            )),
      ),
    );
  }
}
