import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/data/models/detail_surah.dart' as detail;
import 'package:my_alquran/app/data/models/surah.dart';
import 'package:my_alquran/app/constant/color.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Surah ${surah.name?.transliteration?.id?.toUpperCase() ?? "Error...."}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () {
              Get.dialog(Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode
                        ? appGrey
                        : appLightPurple.withOpacity(0.3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        " Tafsir ${surah.name?.transliteration?.id ?? "Error...."}",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${surah.tafsir!.id ?? "error...."}",
                        style: TextStyle(
                            color: Get.isDarkMode ? appWhite : appLightPurple),
                      ),
                    ],
                  ),
                ),
              ));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      appDarkPurple,
                      appLightPurple,
                    ])),
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        surah.name!.transliteration!.id?.toUpperCase() ??
                            'null',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: appWhite),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '( ${surah.name!.translation!.id} )',
                      style: TextStyle(fontSize: 16, color: appWhite),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        ' ${surah.numberOfVerses} Ayat | ${surah.revelation!.id}',
                        style: TextStyle(fontSize: 16, color: appWhite),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.DetailSurah>(
              future: controller.getDetailSurah(surah.number.toString()),
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
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.verses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.verses?.length == 0 ||
                          snapshot.data?.verses?.length == null) {
                        return SizedBox();
                      }
                      detail.Verse? ayat = snapshot.data?.verses?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: appGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(Get.isDarkMode
                                                    ? "assets/images/border_light.png"
                                                    : "assets/images/border_dark.png"),
                                                fit: BoxFit.cover)),
                                        child: Center(
                                          child: Text('${index + 1}'),
                                        )),
                                    GetBuilder<DetailSurahController>(
                                        builder: ((c) => Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons
                                                        .bookmark_add_outlined)),
                                                (ayat?.audioStatus == 'stop')
                                                    ? IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .playAudio(ayat!);
                                                        },
                                                        icon: Icon(
                                                            Icons.play_arrow))
                                                    : Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          (ayat?.audioStatus ==
                                                                  'playing')
                                                              ? IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .pauseAudio(
                                                                            ayat!);
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .pause),
                                                                )
                                                              : IconButton(
                                                                  onPressed:
                                                                      (() {
                                                                    controller
                                                                        .resumeAudio(
                                                                            ayat!);
                                                                  }),
                                                                  icon: Icon(Icons
                                                                      .play_arrow),
                                                                ),
                                                          IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .stopAudio(
                                                                      ayat!);
                                                            },
                                                            icon: Icon(
                                                                Icons.stop),
                                                          )
                                                        ],
                                                      )
                                              ],
                                            )))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2, top: 10),
                            child: Text(
                              '${ayat?.text?.arab}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${ayat?.text?.transliteration?.en}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${ayat?.translation?.id}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
  }
}
