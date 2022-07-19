import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/juz.dart' as juz;
import 'package:my_alquran/app/data/models/surah.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> surahInThisJus = Get.arguments["surahList"];
  @override
  Widget build(BuildContext context) {
    // print(surahInThisJus[controller.index].name?.transliteration?.id);
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz ${detailJuz.juz}'),
          centerTitle: true,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: detailJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                return Center(
                  child: Text("Tidak ada data"),
                );
              }
              juz.Verses ayat = detailJuz.verses![index];
              if (index != 0) {
                if (ayat.number?.inSurah == 1) {
                  controller.index++;
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (ayat.number?.inSurah == 1)
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
                                      " Tafsir ${ayat.translation?.id?.toUpperCase() ?? "Error...."}",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${ayat.tafsir!.id ?? "error...."}",
                                      style: TextStyle(
                                          color: Get.isDarkMode
                                              ? appWhite
                                              : appLightPurple),
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${surahInThisJus[controller.index].name?.transliteration?.id ?? "Error...."}',
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
                                    '${surahInThisJus[controller.index].name?.translation?.id}',
                                    style: TextStyle(
                                        fontSize: 16, color: appWhite),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      '${surahInThisJus[controller.index].numberOfVerses} Ayat',
                                      style: TextStyle(
                                          fontSize: 16, color: appWhite),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: appGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Get.isDarkMode
                                                ? "assets/images/border_light.png"
                                                : "assets/images/border_dark.png"),
                                            fit: BoxFit.cover)),
                                    child: Center(
                                      child: Text('${ayat.number?.inSurah}'),
                                    )),
                                Text(
                                  "${surahInThisJus[controller.index].name?.transliteration?.id ?? ""}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.bookmark_add_outlined)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.play_arrow))
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 2, top: 10),
                    child: Text(
                      '${ayat.text?.arab}',
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
                    '${ayat.text?.transliteration?.en}',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${ayat.translation?.id}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }));
  }
}
