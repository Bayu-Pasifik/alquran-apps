import 'package:get/get.dart';
import 'package:my_alquran/app/data/models/detail_surah.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  // ! variable untuk deklarasi class AudioPlayer
  final player = AudioPlayer();

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
  void playAudio(Verse ayat) async {
    if (ayat.audio?.primary != null) {
      try {
        await player.stop();
        await player.setUrl(ayat.audio!.primary ?? ayat.audio!.secondary![0]);
        ayat.audioStatus = 'playing';
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
