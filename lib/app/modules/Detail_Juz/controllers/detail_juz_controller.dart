import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:my_alquran/app/data/models/juz.dart';

class DetailJuzController extends GetxController {
  int index = 0;
  int number = 0;

  // ! variable untuk deklarasi class AudioPlayer
  final player = AudioPlayer();

  // ! variable untuk kondisi last verse agar nanti nya tombol play/pause bisa kembali ke keaddan semula
  Verses? lastVerse;

  void playAudio(Verses? ayat) async {
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
  void pauseAudio(Verses? ayat) async {
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
  void resumeAudio(Verses? ayat) async {
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
  void stopAudio(Verses? ayat) async {
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
