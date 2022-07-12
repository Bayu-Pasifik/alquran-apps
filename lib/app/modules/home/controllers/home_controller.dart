import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // ! buat ambil value dark theme
  Rx<bool> isDark = false.obs;
  // ! Buat fungsi / function untuk mengambil data surah
  Future<List<Surah>> getAllSurah() async {
    //! Ambil data dari API
    Uri url = Uri.parse('https://api.quran.sutanlab.id/surah');
    var res = await http.get(url);
    //! Masukkan data ke dalam variable
    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];
    // ! cek data nya apakah null atau tidak
    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }
}
