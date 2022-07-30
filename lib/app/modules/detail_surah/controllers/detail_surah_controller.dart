import 'package:get/get.dart';
import 'package:my_alquran/app/constant/color.dart';
import 'package:my_alquran/app/data/models/db/bookmark.dart';
import 'package:my_alquran/app/data/models/detail_surah.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {
  // ! variable untuk deklarasi class AudioPlayer
  final player = AudioPlayer();

  // ! variable untuk kondisi last verse agar nanti nya tombol play/pause bisa kembali ke keaddan semula
  Verse? lastVerse;

  // ! inisialisasi Database local
  DatabaseManager database = DatabaseManager.instance;
  // ! fungsi untuk menambahkan menambahkan bookmark ke database local
  void bookMark(
      bool lastRead, Verse ayat, DetailSurah surah, int indexAyat) async {
    Database db = await database.db;
    bool flagExist = false;

    // ! cek apakah ayat ini termasuk last read / bukan
    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          columns: ["surah, ayat, juz, via, index_ayat, last_read"],
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz} and via = 'surah' and index_ayat = ${indexAyat} and last_read = 0");
      if (checkData.length > 0) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id}".replaceAll("'", "+"),
        "ayat": ayat.number!.inSurah,
        "juz": ayat.meta!.juz,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0
      });
      Get.back(); // untuk menutup dialog nya
      Get.snackbar("Berhasil", "Berhasil menambahkan data ke bookmark",
          colorText: appWhite);
    } else {
      Get.back();
      Get.snackbar("Terjadi Kesalahan", "Ayat sudah ada di bookmark",
          colorText: appWhite);
    }
    var data = await db.query("bookmark");
    print(data);
  }

  // ! Buat fungsi / function untuk mengambil data surah
  Future<DetailSurah> getDetailSurah(String id) async {
    //! Ambil data dari API
    Uri url = Uri.parse('https://al-quran-xi.vercel.app/surah/$id');
    var res = await http.get(url);
    //! Mapping data ke dalam variable
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    // ! return data nya kedalam bentuk json
    return DetailSurah.fromJson(data);
  }

  // ! Buat fungsi / function untuk memainkan audio
  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      try {
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        // ! jika ada ayat nya maka status nya akan diubah menjadi stop
        lastVerse!.audioStatus = "stop";
        // ! last verse di isi ayat berikut nya
        lastVerse = ayat;
        lastVerse!.audioStatus = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat?.audio?.primary ?? "");
        ayat!.audioStatus = 'playing';
        update();
        await player.play();
        ayat.audioStatus = 'stop';
        update();
        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: e.message.toString(),
        );
        print("Error code: ${e.code}");
        Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: e.message.toString(),
        );
        print("Error message: ${e.message}");
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: e.message.toString(),
        );
        print("Connection aborted: ${e.message}");
      } catch (e) {
        // Fallback for all other errors
        print('An error occured: $e');
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: e.toString(),
        );
      }

// Catching errors during playback (e.g. lost network connection)
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          print('Error code: ${e.code}');
          print('Error message: ${e.message}');
        } else {
          print('An error occurred: $e');
        }
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Audio tidak ditemukan',
      );
    }
    // Catching errors at load time
  }

  // ! Buat fungsi / function untuk mempause audio
  void pauseAudio(Verse? ayat) async {
    try {
      await player.pause();
      ayat!.audioStatus = 'pause';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Error code: ${e.code}");
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all other errors
      print('An error occured: $e');
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: e.toString(),
      );
    }

// Catching errors during playback (e.g. lost network connection)
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
    });
    // Catching errors at load time
  }

  // ! Buat fungsi / function untuk meresume audio
  void resumeAudio(Verse? ayat) async {
    try {
      ayat!.audioStatus = 'playing';
      update();
      await player.play();
      ayat.audioStatus = 'stop';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Error code: ${e.code}");
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all other errors
      print('An error occured: $e');
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: e.toString(),
      );
    }

// Catching errors during playback (e.g. lost network connection)
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
    });
    // Catching errors at load time
  }

  // ! Buat fungsi / function untuk meresume audio
  void stopAudio(Verse? ayat) async {
    try {
      await player.stop();
      ayat!.audioStatus = 'stop';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Error code: ${e.code}");
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: e.message.toString(),
      );
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all other errors
      print('An error occured: $e');
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: e.toString(),
      );
    }

// Catching errors during playback (e.g. lost network connection)
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
    });
    // Catching errors at load time
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
