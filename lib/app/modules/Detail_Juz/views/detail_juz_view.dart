import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/juz.dart' as juz;

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments;
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
              if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                return Center(
                  child: Text("Tidak ada data"),
                );
              }
              juz.Verses ayat = detailJuz.verses![index];
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: Text('${ayat.number?.inSurah}'),
                                )),
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
