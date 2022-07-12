import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_alquran/app/data/models/detail_surah.dart' as detail;
import 'package:my_alquran/app/data/models/surah.dart';

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
          Card(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      surah.name!.transliteration!.id?.toUpperCase() ?? 'null',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '( ${surah.name!.translation!.id} )',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      ' ${surah.numberOfVerses} Ayat | ${surah.revelation!.id}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )),
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
                          Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.bookmark_add_outlined)),
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
                    });
              }),
        ],
      ),
    );
  }
}