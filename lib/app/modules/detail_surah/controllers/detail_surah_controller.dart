import 'package:get/get.dart';
import 'package:my_alquran/app/data/models/detail_surah.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailSurahController extends GetxController {
  // ! Buat fungsi / function untuk mengambil data surah
  Future<DetailSurah> getDetailSurah(String id) async {
    //! Ambil data dari API
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah/$id');
    var res = await http.get(url);
    //! Mapping data ke dalam variable
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    // ! return data nya kedalam bentuk json
    return DetailSurah.fromJson(data);
  }
}
