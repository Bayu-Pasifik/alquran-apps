import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/juz.dart' as juz;
import 'package:my_alquran/app/data/models/surah.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> surahInThisJus = Get.arguments["surahList"];

  /* int number = 0; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz ${detailJuz.juz}'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: detailJuz.verses?.length ?? 0,
          itemBuilder: (context, index) {
            print("index dari listview " + index.toString());
            if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
              return Center(
                child: Text("Tidak ada data"),
              );
            }
            juz.Verses ayat = detailJuz.verses![index];

            if (index != 0) {
              // controller.index + 1;
              if (ayat.number?.inSurah == 1) {
                controller.index = controller.index + 1;
              }
              if (controller.index == surahInThisJus.length) {
                controller.index = (controller.index - surahInThisJus.length);
              }
              if (surahInThisJus.length < controller.index) {
                controller.index = 0;
              }
            }

            Surah surah = surahInThisJus[controller.index];
            print("index dari controller " + controller.index.toString());
            print(surah.name?.transliteration?.id);

            // Surah surah = surahInThisJus[controller.index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                                " Tafsir ${surah.name?.transliteration?.id ?? "Error...."}",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${surah.tafsir?.id ?? "error...."}",
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
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              appDarkPurple,
                              appLightPurple,
                            ])),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                '${surah.name?.transliteration?.id ?? "Error...."}',
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
                              '${surah.name?.translation?.id ?? "Error...."}',
                              style: TextStyle(fontSize: 16, color: appWhite),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: (Center(
                                child: Text(
                                  '${surah.numberOfVerses} Ayat',
                                  style:
                                      TextStyle(fontSize: 16, color: appWhite),
                                ),
                              )),
                            ),
                          ],
                        )),
                  ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: appGrey, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                "${surah.name?.transliteration?.id ?? ""}",
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
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
          },
        ));
  }
}
