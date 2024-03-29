import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/db/bookmark.dart';
import 'package:my_alquran/app/data/models/juz.dart';
import 'package:my_alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  // ! buat ambil value dark theme
  Rx<bool> isDark = false.obs;
  // ! buat menampung list surah
  List<Surah> allSurah = [];
  // ! Buat fungsi / function untuk mengambil data surah
  Future<List<Surah>> getAllSurah() async {
    //! Ambil data dari API
    Uri url = Uri.parse('https://al-quran-xi.vercel.app/surah');
    var res = await http.get(url);
    //! Masukkan data ke dalam variable
    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];
    // ! cek data nya apakah null atau tidak
    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  // ! buat future untuk mengambil data juz
  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 30; i++) {
      Uri url = Uri.parse('https://al-quran-xi.vercel.app/juz/$i');
      var res = await http.get(url);
      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)["data"];
      Juz juz = Juz.fromJson(data);
      allJuz.add(juz);
    }
    return allJuz;
  }

  // ! fungsi untuk ganti tema yang sudah disimpan di local storage
  void changeTheme() {
    final box = GetStorage();
<<<<<<< HEAD

    if (isDark == true) {
=======
    // isDark.toggle();
    if (isDark.isTrue) {
>>>>>>> 9a7bb91 (upgrade to flutter 3.0.5)
      box.write("themeDark", true);
    } else {
      box.remove("themeDark");
    }
<<<<<<< HEAD
    print(isDark);
    isDark.toggle();
=======
    isDark.toggle();
    print("value is dark : " + isDark.value.toString());
    print(box.changes);
>>>>>>> 9a7bb91 (upgrade to flutter 3.0.5)
  }

  // ! inisialisasi Database
  DatabaseManager database = DatabaseManager.instance;
  // ! buat fungsi untuk menampilkan bokmark surah
  Future<List<Map<String, dynamic>>> getAllBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark =
        await db.query("bookmark", where: "last_read = 0");
    return allBookmark;
  }

  // ! buat fungsi untuk menghapus bokmark juz
  void deleteBookmark(int id) async {
    Database db = await database.db;
    db.delete("bookmark", where: "id = $id");
    update();
    Get.snackbar("Berhasil", "Berhasil Menghapus Bookmark",
        colorText: appWhite);
  }
}
