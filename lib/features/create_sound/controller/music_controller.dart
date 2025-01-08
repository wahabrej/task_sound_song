import 'package:get/get.dart';

class MusicController extends GetxController {
  final isPlayingMap = <int, RxBool>{}.obs;

  void togglePlayPause(int index) {
    if (!isPlayingMap.containsKey(index)) {
      isPlayingMap[index] = false.obs;
    }

    isPlayingMap.forEach((key, value) {
      if (key != index) {
        value.value = false; 
      }
    });

    isPlayingMap[index]!.value = !isPlayingMap[index]!.value;
  }

  bool isPlaying(int index) {
    return isPlayingMap[index]?.value ?? false;
  }
}
