import 'package:get/get.dart';
import 'package:my_alquran/app/data/models/detail_surah.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
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
  playAudio(String? url) async {
    if (url != null) {
      try {
        await player.setUrl(url);
        await player.play();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: 'Error',
          middleText: e.message.toString(),
        );
        print("Error code: ${e.code}");
        Get.defaultDialog(
          title: 'Error',
          middleText: e.message.toString(),
        );
        print("Error message: ${e.message}");
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: 'Error',
          middleText: e.message.toString(),
        );
        print("Connection aborted: ${e.message}");
      } catch (e) {
        // Fallback for all other errors
        print('An error occured: $e');
        Get.defaultDialog(
          title: 'Error',
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
    }
    // Catching errors at load time
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
