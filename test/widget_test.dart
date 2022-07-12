import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_alquran/app/data/models/detail_surah.dart';
// import 'package:my_alquran/app/data/models/surah.dart';

void main() async {
  // Test ambil data surah
  // Uri url = Uri.parse('https://api.quran.sutanlab.id/surah');
  // var res = await http.get(url);
  // print(res.body);
  // var surah = json.decode(res.body) as Map<String, dynamic>;
  // print(surah["data"][1]["name"]);

  //! Test ambil data kemudian masukkan ke class model yg sudah ada (raw data ke model)
  // var getSurah = Surah.fromJson(surah["data"][1]);
  // print(getSurah.tafsir!.id);

  // ! Test api get detail surah
  Uri urlDetail = Uri.parse('https://api.quran.sutanlab.id/surah/2');
  var resDetail = await http.get(urlDetail);
  var detail = json.decode(resDetail.body) as Map<String, dynamic>;
  // print(detail["data"]["name"]);
  //! Test ambil data kemudian masukkan ke class model yg belum ada (raw data ke model)
  var getDetail = DetailSurah.fromJson(detail["data"]);
  print(getDetail.tafsir!.id);
}
