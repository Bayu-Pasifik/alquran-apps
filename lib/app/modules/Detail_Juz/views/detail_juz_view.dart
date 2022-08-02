import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/juz.dart' as juz;
import 'package:my_alquran/app/data/models/surah.dart';
// import 'package:my_alquran/app/data/models/detail_surah.dart' as detail;

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
        body: ListView(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              itemCount: detailJuz.totalVerses ?? 0,
              itemBuilder: (context, index) {
                print("index dari listview " + index.toString());
                if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                  return Center(
                    child: Text("Tidak ada data"),
                  );
                }
                juz.Verses ayat = detailJuz.verses![index];
                // juz.Audio? verse = detailJuz.verses![index].audio;
                // juz.Verses verse = detailAudio;

                //  detail.Verse? ayat = snapshot.data?.verses?[index];
                //FIXME: membuat card yg menampilkan semua surah pada juz tertentu
<<<<<<< HEAD
                Surah surah = surahInThisJus[controller.index];

                if (ayat.number?.inSurah == 1) {
=======
                if (index != 0) if (ayat.number?.inSurah == 1) {
>>>>>>> 9a7bb91 (upgrade to flutter 3.0.5)
                  controller.index++;
                  if (controller.index == surahInThisJus.length) {
                    controller.index =
                        (controller.index - surahInThisJus.length);
                  }
                  if (controller.index >= 2) {
                    controller.index - 1;
                  }
                }
<<<<<<< HEAD
=======
                Surah surah = surahInThisJus[controller.index];
>>>>>>> 9a7bb91 (upgrade to flutter 3.0.5)

                // Surah surah = surahInThisJus[controller.index];
                // print("index dari controller " + controller.index.toString());
                // print(surah.name?.transliteration?.id);

                // Surah surah = surahInThisJus[controller.index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // if (ayat.number?.inSurah == 1)
                    //   GestureDetector(
                    //     onTap: () {
                    //       Get.dialog(Dialog(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Container(
                    //           padding: EdgeInsets.all(20),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             color: Get.isDarkMode
                    //                 ? appGrey
                    //                 : appLightPurple.withOpacity(0.3),
                    //           ),
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Text(
                    //                 " Tafsir ${surah.name?.transliteration?.id ?? "Error...."}",
                    //               ),
                    //               SizedBox(
                    //                 height: 20,
                    //               ),
                    //               Text(
                    //                 "${surah.tafsir?.id ?? "error...."}",
                    //                 style: TextStyle(
                    //                     color: Get.isDarkMode
                    //                         ? appWhite
                    //                         : appLightPurple),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ));
                    //     },
                    //     child: Container(
                    //         width: Get.width,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             gradient: LinearGradient(colors: [
                    //               appDarkPurple,
                    //               appLightPurple,
                    //             ])),
                    //         child: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Padding(
                    //               padding: const EdgeInsets.only(top: 10),
                    //               child: Text(
                    //                 '${surah.name?.transliteration?.id ?? "Error...."}',
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 20,
                    //                     color: appWhite),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text(
                    //               '${surah.name?.translation?.id ?? "Error...."}',
                    //               style: TextStyle(fontSize: 16, color: appWhite),
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(bottom: 10),
                    //               child: (Center(
                    //                 child: Text(
                    //                   '${surah.numberOfVerses} Ayat',
                    //                   style:
                    //                       TextStyle(fontSize: 16, color: appWhite),
                    //                 ),
                    //               )),
                    //             ),
                    //           ],
                    //         )),
                    //   ),
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
                            mainAxisSize: MainAxisSize.max,
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
                                  // Text(
                                  //   "${surah.name?.transliteration?.id ?? ""}",
                                  //   style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontStyle: FontStyle.italic),
                                  // ),
                                ],
                              ),
                              GetBuilder<DetailJuzController>(
                                builder: (c) => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Bookmark",
                                              middleText:
                                                  "Pilih jenis Bookmark",
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.bookMark(true, ayat,
                                                        surah, index);
                                                  },
                                                  child: Text("Last Read"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              appNormalPurple),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.bookMark(false, ayat,
                                                        surah, index);
                                                  },
                                                  child: Text("Bookmark"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              appNormalPurple),
                                                ),
                                              ]);
                                        },
                                        icon:
                                            Icon(Icons.bookmark_add_outlined)),
                                    (ayat.audioStatus == 'stop')
                                        ? IconButton(
                                            onPressed: () {
                                              controller.playAudio(ayat);
                                            },
                                            icon: Icon(Icons.play_arrow))
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              (ayat.audioStatus == 'playing')
                                                  ? IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .pauseAudio(ayat);
                                                      },
                                                      icon: Icon(Icons.pause),
                                                    )
                                                  : IconButton(
                                                      onPressed: (() {
                                                        controller
                                                            .resumeAudio(ayat);
                                                      }),
                                                      icon: Icon(
                                                          Icons.play_arrow),
                                                    ),
                                              IconButton(
                                                onPressed: () {
                                                  controller.stopAudio(ayat);
                                                },
                                                icon: Icon(Icons.stop),
                                              )
                                            ],
                                          )
                                  ],
                                ),
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
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
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
            ),
          ],
        ));
  }
}
