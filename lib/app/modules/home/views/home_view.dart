import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/surah.dart';
import 'package:my_alquran/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Home'),
        backgroundColor: appNormalPurple,
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
                    color: appNormalPurple),
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
              TabBar(
                  labelColor: appDarkPurple,
                  indicatorColor: appNormalPurple,
                  unselectedLabelColor: appGrey,
                  tabs: [
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
                              leading:
                                  CircleAvatar(child: Text("${surah.number}")),
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
                  Center(child: Text("page juz")),
                  Center(child: Text("Page bookmark")),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
